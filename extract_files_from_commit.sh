# 사용자 입력: 커밋 해시
COMMIT_HASH=$1

# 1. 수정된 파일 목록 추출
MODIFIED_FILES=$(git diff-tree --no-commit-id --name-only -r $COMMIT_HASH)

# 2. 임시 디렉토리 생성
TEMP_DIR="files_from_commit_$COMMIT_HASH"
mkdir -p $TEMP_DIR

# 3. 수정된 파일 복사
for FILE in $MODIFIED_FILES; do
  # 디렉토리 구조 유지하며 파일 복사
  mkdir -p "$TEMP_DIR/$(dirname $FILE)"
  cp "$FILE" "$TEMP_DIR/$FILE" 2>/dev/null || echo "Warning: $FILE could not be copied"
done

# 4. 압축 파일 생성
ZIP_FILE="commit_$COMMIT_HASH.zip"
zip -r $ZIP_FILE $TEMP_DIR

# 5. 압축 완료 후 임시 디렉토리 삭제
rm -rf $TEMP_DIR

# 결과 알림
echo "Modified files from commit $COMMIT_HASH have been archived into $ZIP_FILE"