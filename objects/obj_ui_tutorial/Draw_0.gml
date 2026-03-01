if(!instance_exists(obj_player_tutorial) || global.transicao) exit;

if (botao == "mover" && !global.ui_mover) 
{
    image_index = 0;
    draw_self();
    
}else if(botao == "mover" && global.ui_mover)
{
    image_index = 1;
    draw_self();
    
}

if (botao == "inverte" && obj_player_tutorial.poder) 
{
    image_index = 3;
    contador++;
    if(contador >= 30)
    {
        draw_self();
        contador = 31;
        
    }
        
}






