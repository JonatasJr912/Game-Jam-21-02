if (!instance_exists(obj_player)) exit;

// Decide qual frame usar ANTES de desenhar
if (botao == "mover")
{
    if (obj_player.pontos_movimento <= 0) image_index = 2;
    else if (global.ui_mover)            image_index = 1;
    else                                 image_index = 0;
}
else if (botao == "inverte")
{
    if (obj_player.pontos_acao > 0) image_index = 3;
    else                            image_index = 4;
}
else if (botao == "fim_turno")
{
    if (obj_player.pontos_movimento > 0 || obj_player.pontos_acao > 0) image_index = 5;
    else                                                               image_index = 6;
}

// AGORA desenha
draw_self();