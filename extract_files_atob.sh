#!/bin/bash

# 사용자 입력: 시작 커밋과 끝 커밋
START_COMMIT=$1
END_COMMIT=$2

# 1. A커밋부터 B커밋까지 수정된 파일 목록 추출
MODIFIED_FILES=$(git diff --name-only $START_COMMIT $END_COMMIT)

# 2. 임시 디렉토리 생성
TEMP_DIR="files_from_${START_COMMIT}_to_${END_COMMIT}"
mkdir -p $TEMP_DIR

# 3. 수정된 파일 복사
for FILE in $MODIFIED_FILES; do
  # 디렉토리 구조 유지하며 파일 복사
  mkdir -p "$TEMP_DIR/$(dirname $FILE)"
  cp "$FILE" "$TEMP_DIR/$FILE" 2>/dev/null || echo "Warning: $FILE could not be copied"
done

# 4. 압축 파일 생성
ZIP_FILE="changes_${START_COMMIT}_to_${END_COMMIT}.zip"
zip -r $ZIP_FILE $TEMP_DIR

# 5. 압축 완료 후 임시 디렉토리 삭제
rm -rf $TEMP_DIR

# 결과 알림
echo "Modified files from $START_COMMIT to $END_COMMIT have been archived into $ZIP_FILE"