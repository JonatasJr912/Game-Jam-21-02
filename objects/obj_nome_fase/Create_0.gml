depth = -1000;

//Variáveis nome fase
texto = scr_nome_fase(room);
chars = 0;
vel = 0.5;
acabou = false;

// Evita criar UI duplicada se por algum motivo já existir
if (!instance_exists(obj_ui_turno_player))
{
    instance_create_layer(0, 90, "UI", obj_ui_turno_player);
}
