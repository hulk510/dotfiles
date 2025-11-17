-- ===================================================================
-- カーソルアニメーション (smear-cursor.nvim)
-- カーソル移動時に残像エフェクトを追加
-- ===================================================================

return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- カーソル色は自動検出（カラースキームから）
    cursor_color = "#d9e0ee",
    
    -- 残像エフェクトの設定
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    
    -- スクロールの設定
    scroll_buffer_space = true,
    
    -- 残像の長さ（フレーム数）
    legacy_computing_symbols_support = false,
    
    -- ステンシルバッファサイズ
    stiffness = 0.8,  -- 硬さ（0-1、大きいほど硬い）
    trailing_stiffness = 0.5,  -- 残像の硬さ
    trailing_exponent = 0.1,  -- 残像の減衰率
    distance_stop_animating = 0.5,
    hide_target_hack = false,
  },
}