# Trading System — 차트패턴 + 엘리어트 + 피보나치 + 백테스트

`trading_system.py` 하나로 아래 기능을 모두 제공합니다.

| 기능 | 파일 내 모듈 | 출력 |
|---|---|---|
| 14개 차트패턴 자동 탐지 | `detect_*` | confidence 0~100 |
| 엘리어트 파동 시나리오 | `elliott_wave()` | 1~5 라벨 + 현재 위치 |
| 피보나치 되돌림/확장 | `fibonacci_levels()` | 0.382/0.5/0.618 구간 |
| 6-factor 스코어링 | `generate_report()` | 4단계 등급 |
| 백테스트 | `backtest_all()` | 승률/PF/MDD/Sharpe |
| 멀티 타임프레임 | `multi_timeframe_report()` | 주봉+일봉 통합 |
| 텔레그램/이메일 알림 | `dispatch_alert()` | strong_buy 자동 발송 |
| KRX 전종목 매핑 | `load_krx_tickers()` | 종목명 → 티커 |
| 포지션 사이징 | `build_position_plan()` | 분할매수/매도 플랜 |
| 차트 시각화 | `plot_chart()` | PNG 저장 |

---

## 빠른 시작 (Windows)

### 1. Python 설치 (최초 1회)
- https://www.python.org/downloads/ 에서 **Python 3.11 이상** 설치
- ⚠️ 설치 시 **"Add Python to PATH"** 체크박스 반드시 켜기

### 2. 패키지 설치
```bash
scripts\install.bat
```
(더블클릭도 가능)

### 3. 실행
```bash
scripts\run.bat
```

---

## 직접 실행 (Mac/Linux 또는 수동)

```bash
cd scripts
python -m venv venv
source venv/bin/activate       # Windows: venv\Scripts\activate
pip install -r requirements.txt
python trading_system.py
```

---

## 종목 입력 방법

`trading_system.py` 맨 아래 `__main__` 블록에서 수정:

```python
tickers = [
    "SK하이닉스",        # 종목명 (KR_TICKER_MAP 또는 pykrx로 변환)
    "000660.KS",         # yfinance 티커 직접 입력
    "AAPL",              # 해외 주식도 가능
]
```

### KRX 전종목 지원
`pykrx`가 설치되어 있으면 KOSPI/KOSDAQ 모든 종목명을 자동 인식합니다.
(최초 1회 약 30초 소요, 이후 7일간 캐시)

---

## 알림 설정 (선택)

### 텔레그램
1. [@BotFather](https://t.me/BotFather)에서 `/newbot` → 봇 생성, 토큰 받기
2. 본인이 봇에게 아무 메시지 전송
3. `https://api.telegram.org/bot<TOKEN>/getUpdates` 접속 → `chat.id` 복사
4. `config.example.py`를 `config.py`로 복사 후 값 입력

### 이메일 (Gmail)
1. Google 계정 → 보안 → **앱 비밀번호** 생성
   (2단계 인증 먼저 켜야 옵션 나타남)
2. `config.py`에 앱 비밀번호 입력

---

## 주요 함수 사용법

### 단일 종목 전체 분석
```python
from trading_system import get_data, generate_report, plot_chart

df = get_data("000660.KS", period="1y")
report = generate_report("000660.KS", df)
print(report.decision, report.score)
plot_chart("000660.KS", df, report, save=True)
```

### 백테스트
```python
from trading_system import backtest_all
df = get_data("000660.KS", period="5y")
stats = backtest_all(df, hold_days=20)
print(stats[["pattern", "win_rate", "profit_factor", "sharpe"]])
```

### 포지션 플랜
```python
from trading_system import build_position_plan, format_position_plan
plan = build_position_plan(report, capital=10_000_000, risk_pct=0.01)
print(format_position_plan(plan))
```

### 멀티 타임프레임
```python
from trading_system import multi_timeframe_report
r = multi_timeframe_report("AAPL")
print(r["final_decision"], r["note"])
```

---

## 스코어링 등급

| 점수 | 등급 | 해석 |
|---|---|---|
| 85+ | `strong_buy` | 현 구간 분할매수 적정 |
| 70~84 | `pullback_buy` | 눌림목 대기 후 매수 |
| 55~69 | `watch` | 관찰만, 진입 보류 |
| <54 | `avoid` | 회피 |

---

## 주의사항

1. **엘리어트 파동은 시나리오**일 뿐, 확정이 아닙니다. 반드시 "가능성"으로 해석하세요.
2. **백테스트 결과는 과거**입니다. 현재 장세에 재현되지 않을 수 있습니다.
3. **손절 준수가 전제**입니다. 손절 안 지키면 리스크 관리가 무의미합니다.
4. **pykrx / yfinance는 상장폐지·거래정지 종목**이 누락될 수 있습니다.
5. 실매매 연결은 법적/리스크 책임이 크므로, **알림은 수동 확인용**으로만 사용하세요.

---

## 구조

```
scripts/
├── trading_system.py       # 메인 (약 900줄)
├── requirements.txt        # 패키지 목록
├── config.example.py       # 알림 템플릿
├── install.bat             # 설치 스크립트
├── run.bat                 # 실행 스크립트
└── README.md               # 이 파일
```
