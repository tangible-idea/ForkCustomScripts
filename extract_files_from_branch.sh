#!/bin/bash

# 브랜치 이름을 입력으로 받음
BRANCH_NAME=$1

# 브랜치 이름이 제공되지 않은 경우 사용법 출력 후 종료
if [ -z "$BRANCH_NAME" ]; then
  echo "사용법: $0 <브랜치 이름>"
  exit 1
fi

# 브랜치 이름에 '/' 등 특수 문자가 포함된 경우 안전하게 처리
BRANCH_NAME=$(echo "$BRANCH_NAME" | sed 's/[]$.*[\^]/\\&/g')

# 현재 브랜치 이름 가져오기
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 입력받은 브랜치가 존재하는지 확인
if ! git rev-parse --verify "$BRANCH_NAME" >/dev/null 2>&1; then
  echo "에러: 브랜치 '$BRANCH_NAME'가 존재하지 않습니다."
  exit 1
fi

# 현재 브랜치와 대상 브랜치 간의 수정된 파일 목록 가져오기
echo "브랜치 '$BRANCH_NAME'에서 수정된 파일을 수집 중입니다..."
MODIFIED_FILES=$(git diff --name-only "$CURRENT_BRANCH".."$BRANCH_NAME")

# 수정된 파일이 없는 경우 종료
if [ -z "$MODIFIED_FILES" ]; then
  echo "현재 브랜치와 '$BRANCH_NAME' 사이에 수정된 파일이 없습니다."
  exit 0
fi

# 임시 디렉토리 생성 (디렉토리 이름에 '/' 대신 '_' 사용)
TEMP_DIR="modified_files_$(echo "$BRANCH_NAME" | tr '/' '_')"
mkdir -p "$TEMP_DIR"

# 수정된 파일들을 임시 디렉토리로 복사
echo "수정된 파일을 임시 디렉토리로 복사 중..."
for FILE in $MODIFIED_FILES; do
  # 디렉토리 구조를 유지하면서 파일 복사
  mkdir -p "$TEMP_DIR/$(dirname "$FILE")"
  cp "$FILE" "$TEMP_DIR/$FILE" 2>/dev/null || echo "경고: $FILE 파일을 복사할 수 없습니다."
done

# 복사된 파일들의 디렉토리 구조를 표시
echo "수정된 파일들의 디렉토리 구조:"
if command -v tree >/dev/null 2>&1; then
  # tree 명령어가 설치되어 있으면 디렉토리 구조 표시
  tree "$TEMP_DIR"
else
  # tree 명령어가 없으면 find 명령어로 기본 구조 표시
  echo "'tree' 명령어가 설치되어 있지 않습니다. 기본 디렉토리 목록을 표시합니다:"
  find "$TEMP_DIR"
fi

# zip 파일 생성 (파일명에 '변경사항_' 접두어 사용)
ZIP_FILE="변경사항_$(echo "$BRANCH_NAME" | tr '/' '_').zip"
echo "압축 파일 '$ZIP_FILE' 생성 중..."
zip -r "$ZIP_FILE" "$TEMP_DIR" >/dev/null

# 임시 디렉토리 삭제
rm -rf "$TEMP_DIR"

# 완료 메시지 출력
echo "완료! 수정된 파일들이 '$ZIP_FILE'에 저장되었습니다."