
require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}

Status:children_add(function()
    local free_space_command = "df -BG . | tail -n1 | awk '{printf $(NF-2)}'"
    local free_space_str     = io.popen(free_space_command):read('*a')
    local free_space_num     = tonumber(free_space_str:match("(%d+)"))
    local G_LEFT             = ""
    local G_RIGHT            = ""
    local BG_COLOR           = "#3A3A3A"
    local FG_COLOR           = "#F0C665"
    if free_space_num < 50 then
        BG_COLOR = "#502020"
        FG_COLOR = "#E06C75"
    end

    local free_space_badge = ui.Line({
        ui.Span(" "):fg(BG_COLOR), -- Espace avant le badge pour séparer du reste

        ui.Span(G_LEFT):fg(BG_COLOR),

        ui.Span(free_space_str .. " de libre"):fg(FG_COLOR):bg(BG_COLOR),

        ui.Span(G_RIGHT):fg(BG_COLOR),

        ui.Span(" "):fg(BG_COLOR), -- Espace après le badge pour séparer du reste
    })

    return free_space_badge
end, 0, Header.RIGHT)

