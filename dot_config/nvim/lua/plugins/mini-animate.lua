-- ===================================================================
-- アニメーション効果 (mini.animate)
-- カーソル移動、スクロール、ウィンドウサイズ変更にアニメーション
-- ===================================================================

return {
  "echasnovski/mini.animate",
  event = "VeryLazy",
  config = function()
    local animate = require("mini.animate")

    -- マウススクロール検出（スクロールアニメーション無効化用）
    local mouse_scrolled = false
    for _, scroll in ipairs({ "Up", "Down" }) do
      local key = "<ScrollWheel" .. scroll .. ">"
      vim.keymap.set({ "", "i" }, key, function()
        mouse_scrolled = true
        return key
      end, { expr = true })
    end

    animate.setup({
      -- カーソルアニメーション（w, b, j, k などの移動で動く）
      cursor = {
        enable = true,
        -- 軽快でキビキビした動き
        timing = animate.gen_timing.exponential({ duration = 50, unit = "total" }),
        -- カーソルパス生成（直線移動）
        path = animate.gen_path.line(),
      },

      -- スクロールアニメーション
      scroll = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 120, unit = "total" }),
        subscroll = animate.gen_subscroll.equal({
          predicate = function(total_scroll)
            if mouse_scrolled then
              mouse_scrolled = false
              return false
            end
            return total_scroll > 1
          end,
        }),
      },

      -- ウィンドウリサイズアニメーション
      resize = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 80, unit = "total" }),
      },

      -- ウィンドウオープン/クローズは無効（重いため）
      open = { enable = false },
      close = { enable = false },
    })
  end,
}
