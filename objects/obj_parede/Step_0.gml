
//Checando o estado do mundo
if (global.mundo == "normal") 
{
    image_index = 0;
    image_alpha = meu_alpha;
    depth = -y;
}
else 
{
    image_index = 1;
    image_alpha = 1;
    depth = +y;
    
}
        
       


//show_debug_message("Depth da parede: " + string(depth));