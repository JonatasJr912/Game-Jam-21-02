//Depth de todas as entidades serão esse valor
depth = -y + 5; 

estado();

show_debug_message(string(room) + string(1))

if (keyboard_check_pressed(vk_tab)) 
{ 
    show_debug_overlay(true);
  
}

if (keyboard_check_pressed(vk_enter) && estado == estado_parado) 
{ 
    
    global.ui_turnos = false;
    
    global.pedido_fim_turno = true;
    if (layer_exists("TutorialCombate")) 
        {
            
            layer_destroy("TutorialCombate");
            
        }
  
}






