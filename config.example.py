"""
trading_system.py 알림/설정 템플릿.

사용법:
    1) 이 파일을 config.py로 복사
    2) 아래 값들 채우기
    3) trading_system.py 맨 위에 `from config import *` 추가해서 불러오기

보안:
    config.py는 .gitignore에 추가되어 있음 (커밋 방지).
"""

# ─── 분석할 종목 ───
TICKERS = [
    "SK하이닉스",
    "000660.KS",
    "AAPL",
    # 추가...
]

# ─── 자본 / 리스크 ───
CAPITAL = 10_000_000          # 원
RISK_PER_TRADE = 0.01         # 1% (공격적이면 0.02)

# ─── 텔레그램 알림 ───
# 1) @BotFather 에서 봇 생성 → 토큰 받기
# 2) 본인이 봇에게 /start 메시지 전송
# 3) https://api.telegram.org/bot<TOKEN>/getUpdates 접속 → chat.id 확인
TELEGRAM = {
    "token": "123456789:ABC-DEF...",   # 여기 입력
    "chat_id": "123456789",            # 여기 입력
}

# ─── 이메일 알림 (Gmail 기준) ───
# Gmail은 "앱 비밀번호" 사용 (일반 비밀번호 X)
# https://myaccount.google.com/apppasswords
EMAIL = {
    "smtp": "smtp.gmail.com",
    "port": 465,
    "user": "your@gmail.com",
    "password": "abcd efgh ijkl mnop",   # 앱 비밀번호
    "from": "your@gmail.com",
    "to": "your@gmail.com",
}

# ─── 알림 트리거 등급 ───
# ("strong_buy",) → strong_buy만 알림
# ("strong_buy", "pullback_buy") → 둘 다 알림
TRIGGER_DECISIONS = ("strong_buy",)
