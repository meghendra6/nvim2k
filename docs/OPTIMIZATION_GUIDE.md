# 🚀 Neovim 설정 최적화 및 버퍼 관리 가이드

## 📋 적용된 최적화 목록

### 1. ⚡ 성능 최적화

#### 변경 사항:
1. **vim-oscyank 플러그인 Lazy Loading**
   - `lazy = false` → `event = 'VeryLazy'`로 변경
   - 즉시 로드 불필요한 플러그인을 지연 로딩하여 시작 속도 개선

2. **Snacks.nvim 기능 최적화**
   - `animate.enabled = false`: 애니메이션 비활성화로 성능 향상
   - `dim.enabled = false`: dim 기능 기본 비활성화 (필요시 `<leader>wd`로 활성화)
   - `scroll.enabled = false`: 스크롤 애니메이션 비활성화

3. **Lazy.nvim 내장 플러그인 비활성화**
   - 사용하지 않는 Vim 내장 플러그인들을 비활성화하여 시작 속도 개선

#### 예상 효과:
- 시작 시간: ~147ms → 80-100ms로 단축
- 버퍼 열기/전환 속도 향상
- 전반적인 UI 반응 속도 개선

---

### 2. 🔍 Python LSP 개선 (외부 라이브러리 정의 탐색)

#### 문제:
- Python 코드 내에서 `gd`로 현재 파일의 정의는 찾지만, `import`한 외부 라이브러리 안쪽까지는 탐색하지 못함

#### 해결책:
**pyright 사용** (`lua/plugins/lang/lspconfig.lua`):

```lua
pyright = function()
    lspconfig.pyright.setup({
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,        -- ✅ 자동 경로 탐색
                    diagnosticMode = "workspace",  -- ✅ 전체 워크스페이스 분석
                    useLibraryCodeForTypes = true, -- ✅ 라이브러리 타입 정보 사용
                    typeCheckingMode = "basic"     -- 타입 체킹 활성화
                }
            }
        },
    })
end,
```

#### 사용법:
1. Python 파일에서 외부 라이브러리 함수/클래스에 커서를 놓습니다
2. `gd` (Goto Definition) 또는 `<leader>ld` (Lspsaga Goto Definition) 입력
3. 이제 `numpy`, `pandas`, `requests` 등 외부 라이브러리 내부 정의로 이동 가능!

#### 추가 LSP 단축키:
- `gd`: 정의로 이동 (Lspsaga)
- `<leader>ld`: 정의로 이동 (Lspsaga)
- `<leader>lD`: 정의 미리보기 (Peek Definition)
- `<leader>lr`: 심볼 이름 변경 (Rename)
- `<leader>lf`: 레퍼런스 찾기 (Find References)
- `K`: 함수/클래스 설명 보기 (Hover Documentation)

---

### 3. 🗂️ 버퍼 관리 단축키 완전 가이드

#### 📌 버퍼 내비게이션 (이동)
| 단축키 | 기능 | 설명 |
|--------|------|------|
| `<S-h>` | 이전 버퍼 | Shift + H로 이전 버퍼로 이동 |
| `<S-l>` | 다음 버퍼 | Shift + L로 다음 버퍼로 이동 |
| `<leader>ea` | 대체 파일 전환 | 직전에 열었던 파일로 전환 (`:b#`) |

#### 🔎 버퍼 검색 및 선택
| 단축키 | 기능 | 설명 |
|--------|------|------|
| `<leader>fb` | 버퍼 목록 (빠른 접근) | Telescope로 버퍼 검색 및 전환 |
| `<leader>fj` | 버퍼 목록 (전체) | 모든 열린 버퍼 목록 보기 |
| `<leader>fo` | 열린 파일에서 검색 | 현재 열린 버퍼들 내에서 텍스트 검색 |

**Telescope 버퍼 목록 사용법:**
1. `<leader>fb` 입력
2. 버퍼 이름 입력 (fuzzy search)
3. `<CR>` (Enter)로 선택
4. `<C-x>`: 수평 분할로 열기
5. `<C-v>`: 수직 분할로 열기
6. `<C-d>`: 버퍼 삭제

#### ❌ 버퍼 닫기/삭제
| 단축키 | 기능 | 설명 |
|--------|------|------|
| `<leader>qb` | 버퍼 닫기 | 현재 버퍼를 완전히 제거 (`:bw`) |
| `<leader>qd` | 버퍼 스마트 삭제 | Snacks의 스마트 삭제 (레이아웃 유지) |
| `<leader>qo` | 다른 버퍼 모두 닫기 | 현재 버퍼만 남기고 모두 닫기 |
| `<leader>fx` | 예외 처리 닫기 | 현재 버퍼 제외 모두 삭제 |

**차이점:**
- `<leader>qb` (`:bw`): 버퍼를 완전히 제거하고 메모리에서 삭제
- `<leader>qd` (Snacks): 스마트하게 삭제하며 창 레이아웃을 유지
- `<leader>qo`: 다른 모든 버퍼 닫기 (탭 정리에 유용)

#### 💡 고급 버퍼 관리 팁

**1. 여러 버퍼를 한 번에 닫고 싶을 때:**
```vim
:%bd|e#|bd#    " 현재 버퍼만 남기고 모두 닫기
```
이미 `<leader>qo`에 매핑되어 있습니다!

**2. 버퍼 번호로 직접 이동:**
```vim
:b <번호>      " 예: :b 3
:b <파일명>    " 예: :b main.py
```

**3. 버퍼 목록 확인:**
```vim
:ls            " 모든 버퍼 목록 보기
```

**4. 수정되지 않은 버퍼만 닫기:**
```vim
:bufdo if !&modified | bdelete | endif
```

---

## 🎯 실전 워크플로우 예제

### 시나리오 1: 여러 파일 작업 후 정리
```
1. 여러 파일 편집 후 버퍼가 많아짐
2. <leader>fb 입력 → 필요한 파일만 선택
3. <leader>qo 입력 → 현재 버퍼만 남기고 모두 닫기
```

### 시나리오 2: Python 라이브러리 코드 탐색
```
1. import numpy as np
2. arr = np.array([1, 2, 3])
3. 'array' 위에 커서를 놓고 gd 입력
4. ✅ numpy의 array 함수 정의로 이동!
5. <C-o> 입력으로 원래 위치로 복귀
```

### 시나리오 3: 빠른 버퍼 전환
```
1. 파일 A 편집 중
2. <S-l> 입력 → 파일 B로 전환
3. <leader>ea 입력 → 다시 파일 A로 복귀
```

---

## 📝 추가 최적화 권장사항

### 사용하지 않는 LSP 서버 비활성화
`lua/plugins/list.lua`에서 필요 없는 LSP를 제거하여 시작 속도 향상:

```lua
local lsp_servers = {
    'bashls',
    'jsonls',
    'lua_ls',
    -- 'typos_lsp',  -- 맞춤법 검사 불필요하면 주석 처리
    'vimls',
}
```

### Treesitter 파서 최소화
`lua/plugins/list.lua`의 `locs` 배열에서 사용하지 않는 언어 제거:

```lua
locs = {
    'lua',
    'python',
    'bash',
    'markdown',
    -- 필요한 언어만 남기기
}
```

---

## 🔧 트러블슈팅

### Q1: Python LSP가 여전히 외부 라이브러리를 찾지 못해요
**A:** 다음을 확인하세요:
1. pyright가 올바른 Python 환경을 사용하는지 확인:
   ```vim
   :LspInfo
   ```
2. 가상환경을 사용 중이라면 Neovim을 가상환경 내에서 실행:
   ```bash
   source venv/bin/activate
   nvim
   ```
3. Mason으로 pyright 재설치:
   ```vim
   :Mason
   # pyright 선택 후 'x' (삭제) → 'i' (재설치)
   ```

### Q2: 버퍼 전환이 여전히 느려요
**A:** 추가 최적화 옵션:
1. 더 많은 Snacks 기능 비활성화
2. Treesitter의 `highlight` 범위 제한
3. LSP의 `documentHighlight` 비활성화

### Q3: 시작 속도가 개선되지 않았어요
**A:** 
```vim
:Lazy profile
```
명령으로 어느 플러그인이 느린지 확인하고 추가 lazy loading 적용

---

## 📚 참고 링크

- [Neovim 공식 문서](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Pyright](https://github.com/microsoft/pyright)
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

---

## 🎉 결론

이제 다음이 가능해졌습니다:
- ✅ 더 빠른 Neovim 시작 속도
- ✅ 외부 Python 라이브러리 정의 탐색
- ✅ 효율적인 버퍼 관리 워크플로우

즐거운 코딩 되세요! 🚀
