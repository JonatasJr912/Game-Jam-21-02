if(!instance_exists(obj_player)) exit;
if(!instance_exists(obj_inimigo1) && !instance_exists(obj_inimigo2)) exit;
    

if (obj_player.max_pontos_acao <= 0 && !atencao) 
{
    if(instance_exists(obj_inimigo1) || instance_exists(obj_inimigo2))
    {
        image_index = 3;
  
    }
	
}
    


