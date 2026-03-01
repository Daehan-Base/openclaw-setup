# OpenClaw VPS 설치 가이드

> 코딩 몰라도 됩니다. 24시간 AI 에이전트를 내 서버에 올리는 완전 가이드.  
>
> Thanks to [kokoju007](https://github.com/kokoju007), Base 생태계 빌더 **꼬냑(@kokoju007)** 님의 원본 프로젝트를 기반으로, OpenClaw를 쉽게 설치·설정할 수 있는 스크립트를 제공하는 저장소입니다.  
> Original repository: [https://github.com/kokoju007/openclaw-setup](https://github.com/kokoju007/openclaw-setup)  
> X: [https://x.com/supernovajunn](https://x.com/supernovajunn)

비개발자도 따라할 수 있도록 **Contabo VPS 가입부터 텔레그램 연결까지** 전 과정을 담았습니다.  
이 문서는 **Contabo VPS(Cloud VPS) 기준 가이드**입니다.

---

## ⚡ 원클릭 설치

VPS에 SSH 접속 후 아래 한 줄만 붙여넣으세요:

```bash
curl -fsSL https://raw.githubusercontent.com/kokoju007/openclaw-setup/main/install.sh | bash
```

자동으로 처리되는 것들:

- ✅ Node.js 설치 확인
- ✅ OpenClaw 설치
- ✅ 텔레그램 봇 연결
- ✅ 설정 파일 보안 설정
- ✅ 24시간 자동 실행 등록

---

## 📋 준비물


| 항목                    | 어디서                                                    | 비용       |
| --------------------- | ------------------------------------------------------ | -------- |
| VPS 서버 (Ubuntu 22.04) | [Contabo](https://contabo.com)                         | 월 $6.99~ |
| Claude API 키          | [console.anthropic.com](https://console.anthropic.com) | 사용량 과금   |
| 텔레그램 봇 토큰             | 텔레그램 @BotFather                                        | 무료       |
| 텔레그램 사용자 ID           | 텔레그램 @userinfobot                                      | 무료       |


---

## 📖 상세 가이드

**Releases** 탭에서 PDF 가이드를 다운로드하세요.

Contabo 가입 → SSH 접속 → 설치 → 텔레그램 연결 → API 키 설정까지  
스크린샷 없이도 따라할 수 있게 단계별로 설명합니다.

### VPS 설치 가이드 (OpenClaw)

- 한글: [vps/README.md](./vps/README.md)
- English: [vps/README.en.md](./vps/README.en.md)

해당 문서는 Contabo VPS 생성부터 SSH 접속까지의 화면 기반 순서(스크린샷 포함)를 정리한 기본 가이드입니다.

---

## 🔒 보안

이 스크립트는 다음을 보장합니다:

- 외부 코드 자동 실행 없음 (eval/exec 미사용)
- 개인정보 외부 전송 없음 (토큰은 서버 내부에만 저장)
- 공식 패키지만 사용 (npm + apt 공식 저장소)
- 설정 파일 권한 잠금 (chmod 600 자동 적용)
- 파일 삭제 명령어 없음 (rm -rf 미사용)

코드는 전체 공개되어 있으니 직접 확인하세요.

## ⚠️ Disclaimer

- 본 가이드는 기술적 참고용 자료입니다. 설치/운영 과정에서 발생하는 계정 보안, 토큰 관리, 서버 접근 권한 관리에 대한 최종 책임은 사용자에게 있습니다.
- API 키, 봇 토큰, SSH 키, 비밀번호 등 민감 정보는 채팅으로 공유하지 말고, 로컬에서 안전한 방법(환경변수, 비밀 파일, 마스킹된 입력)으로만 설정하세요.
- 스크립트는 공개 저장소 기반으로 동작하지만, 설치 전 본인 환경의 정책에 맞게 검토 후 진행하는 것을 권장합니다.

---

## 🛠 유용한 명령어

```bash
# 상태 확인
sudo systemctl status openclaw

# 재시작
sudo systemctl restart openclaw

# 실시간 로그
sudo journalctl -u openclaw -f
```

---

## ❓ 자주 묻는 질문

**Q. 봇이 응답을 안 해요**  
봇 토큰과 사용자 ID 확인 후 `sudo systemctl restart openclaw`

**Q. SSH 비밀번호 입력 시 화면에 아무것도 안 보여요**  
정상입니다. 보안상 숨겨지는 거예요. 그냥 치고 엔터 누르면 됩니다.

**Q. 서버 재부팅 후 작동 안 해요**  
`sudo systemctl enable openclaw` 실행 후 재시도

---

## ⭐ Star

도움이 됐다면 Star 눌러주세요. 계속 업데이트합니다.

---

*Made by [@kokoju007](https://github.com/kokoju007)*
