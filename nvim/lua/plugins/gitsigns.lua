return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
        -- See `:help gitsigns.txt`
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
        watch_gitdir = {
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 0,
            ignore_whitespacec = false,
            virt_text_priority = 100,
        },
        on_attach = function(bufnr)
            vim.keymap.set(
                "n",
                "<leader>hp",
                require("gitsigns").preview_hunk,
                { buffer = bufnr, desc = "Preview git hunk" }
            )

            -- don't override the built-in and fugitive keymaps
            local gs = package.loaded.gitsigns
            vim.keymap.set({ "n", "v" }, "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
            vim.keymap.set({ "n", "v" }, "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
        end,
    },
}