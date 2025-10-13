═══════════════════════════════════════════════════════════════════
        ✨ LSP DEFINITION PEEK & SELECT - 설정 완료 ✨
═══════════════════════════════════════════════════════════════════

📝 변경된 키바인딩:

기본 키바인딩:
  • gd  → Peek Definition (Float 창에서 여러 후보 보기)
          - <CR> : 해당 definition으로 점프
          - <C-v> : Vertical split으로 열기
          - <C-x> : Horizontal split으로 열기
          - <C-t> : 새 탭으로 열기
          - q / <Esc> : 닫기

  • gD  → Goto Definition (Direct, 바로 점프)
  
  • gf  → LSP Finder (모든 references/implementations/definitions)
          - <CR> / o : 열기
          - s : Vertical split
          - i : Horizontal split
          - t : 새 탭
          - p : Preview jump
          - q / <ESC> : 닫기

Leader 키바인딩:
  • <leader>lp → Peek Definition (Float 창)
  • <leader>ld → Goto Definition (Direct)
  • <leader>lf → LSP Finder (All References)

🎯 사용 방법:

1. 심볼 위에서 'gd' 입력
   → Float 창이 열리고 definition 목록 표시

2. 여러 definition이 있으면:
   - 방향키나 j/k로 선택
   - <CR> 눌러서 해당 위치로 점프
   - <C-v>로 split 창으로 열기

3. 모든 reference를 보려면:
   - 'gf' 또는 '<leader>lf' 입력
   - Definition, Reference, Implementation 모두 표시

✨ 주요 개선사항:
  • Peek window에서 코드 미리보기
  • 여러 definition 중 선택 가능
  • 다양한 열기 방식 (split, tab 등)
  • 직관적인 키바인딩

═══════════════════════════════════════════════════════════════════