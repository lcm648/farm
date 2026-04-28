# Render/Screenshot Retry Report (2026-04-28 UTC)

요청하신 "실패했던 렌더, 스크린샷 생성 시도"를 재실행했습니다.

## 실행 명령

```bash
./scripts/render_screenshot_retry.sh > artifacts/render-retry.log 2>&1
```

## 결과 요약

- Playwright Chromium 자동 설치 실패 (네트워크 프록시 403)
- `wkhtmltoimage` 미설치
- 대체 산출물로 `assets/pipeline-v3.2.svg`를 `artifacts/pipeline-preview.svg`로 복사

## 생성 파일

- `artifacts/render-retry.log`
- `artifacts/pipeline-preview.svg`

## 로그 발췌

자세한 원문은 `artifacts/render-retry.log`를 확인하세요.
