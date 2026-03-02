var gx = display_get_gui_width()  * 0.5;
var gy = display_get_gui_height() * 0.5;

// Fundo escurecido
draw_set_alpha(0.55);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Popup
var left   = gx - w * 0.5;
var top    = gy - h * 0.5;
var right  = gx + w * 0.5;
var bottom = gy + h * 0.5;

draw_set_color(make_color_rgb(25, 30, 38));
draw_rectangle(left, top, right, bottom, false);

draw_set_color(make_color_rgb(90, 100, 120));
draw_rectangle(left, top, right, bottom, true);

draw_set_font(fnt_nome_intro);

// Título
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(gx, top + 18, "OPÇÕES");

// Layout
var rx = right - 24;
var box = 22;

var y_full  = top + 70;
var y_fxoff = top + 110; // NOVO
var y_mus   = top + 170;
var y_sfx   = top + 230;

draw_set_halign(fa_left);
draw_text(left + 24, top + 55, "Tela cheia");

draw_set_halign(fa_left);
draw_text(left + 24, y_fxoff - 10, "Desativa efeitos (desempenho)");

// Caixa fullscreen
draw_set_color(make_color_rgb(60, 70, 85));
draw_rectangle(rx - box, y_full - box * 0.5, rx, y_full + box * 0.5, false);
draw_set_color(make_color_rgb(110, 120, 140));
draw_rectangle(rx - box, y_full - box * 0.5, rx, y_full + box * 0.5, true);

if (global.fullscreen) {
    draw_set_color(make_color_rgb(120, 220, 140));
    draw_rectangle(rx - box + 4, y_full - box * 0.5 + 4, rx - 4, y_full + box * 0.5 - 4, false);
}

// Caixa "Desativar efeitos"
draw_set_color(make_color_rgb(60, 70, 85));
draw_rectangle(rx - box, y_fxoff - box * 0.5, rx, y_fxoff + box * 0.5, false);
draw_set_color(make_color_rgb(110, 120, 140));
draw_rectangle(rx - box, y_fxoff - box * 0.5, rx, y_fxoff + box * 0.5, true);

if (global.desativar_efeitos) {
    draw_set_color(make_color_rgb(220, 140, 140)); // vermelhozinho pra indicar "off"
    draw_rectangle(rx - box + 4, y_fxoff - box * 0.5 + 4, rx - 4, y_fxoff + box * 0.5 - 4, false);
}

// Sliders
var slider_w = 240;
var slider_h = 12;
var slider_x1 = rx - slider_w;
var slider_x2 = rx;

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(left + 24, y_mus - 10, "Música");
draw_text(left + 24, y_sfx - 10, "Efeitos");

// Barra música
draw_set_color(make_color_rgb(60, 70, 85));
draw_rectangle(slider_x1, y_mus - slider_h * 0.5, slider_x2, y_mus + slider_h * 0.5, false);

var knob_x = lerp(slider_x1, slider_x2, clamp(global.vol_musica, 0, 1));
draw_set_color(c_purple);
draw_circle(knob_x, y_mus, 8, false);

// Barra sfx
draw_set_color(make_color_rgb(60, 70, 85));
draw_rectangle(slider_x1, y_sfx - slider_h * 0.5, slider_x2, y_sfx + slider_h * 0.5, false);

var knob_x2 = lerp(slider_x1, slider_x2, clamp(global.vol_sfx, 0, 1));
draw_set_color(c_purple);
draw_circle(knob_x2, y_sfx, 8, false);

// Porcentagem
draw_set_color(c_white);
draw_set_halign(fa_right);
draw_text(right - 24, y_mus - 10, string(round(global.vol_musica * 100)) + "%");
draw_text(right - 24, y_sfx - 10, string(round(global.vol_sfx * 100)) + "%");

// Botão fechar
var close_w = 120;
var close_h = 32;
var close_x1 = gx - close_w * 0.5;
var close_x2 = gx + close_w * 0.5;
var close_y1 = bottom - 50;
var close_y2 = close_y1 + close_h;

// Botão voltar ao menu
var back_w = 220;
var back_h = 32;
var back_x1 = gx - back_w * 0.5;
var back_x2 = gx + back_w * 0.5;
var back_y2 = close_y1 - 10;
var back_y1 = back_y2 - back_h;

// Desenha voltar ao menu
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(70, 80, 95));
draw_rectangle(back_x1, back_y1, back_x2, back_y2, false);
draw_set_color(make_color_rgb(120, 130, 150));
draw_rectangle(back_x1, back_y1, back_x2, back_y2, true);
draw_set_color(c_white);
draw_text(gx, back_y1 + 7, "Voltar ao Menu");

//Desenha fechar
draw_set_halign(fa_center);
draw_set_color(make_color_rgb(70, 80, 95));
draw_rectangle(close_x1, close_y1, close_x2, close_y2, false);
draw_set_color(make_color_rgb(120, 130, 150));
draw_rectangle(close_x1, close_y1, close_x2, close_y2, true);
draw_set_color(c_white);
draw_text(gx, close_y1 + 7, "Fechar");

draw_set_font(-1);

draw_set_halign(-1);