#region Variáveis

//A malha é criada invisivel
visivel = false;





#endregion

#region Métodos

//Método de checar as malhas disponiveis para movimento
checa_movimento = function()
{
    //Se nenhum tile estiver selecionado ele sai do método
    if(global.tile_atual == noone) exit;
    
    //Se não estiver visível
    if (!visivel) 
    {
        
        //medindo a distância entre os tiles
        var dx = abs(px - global.tile_atual.px);
        var dy = abs(py - global.tile_atual.py);

    
        //Se estiver com 1 de distância algum, e garantindo que não seja ambos zero
        if(dx <= 1 && dy <= 1 && !(dx == 0 && dy == 0))
        {
            //E for diferente de parede
            if (tipo != "parede") 
            {
                //Então fica visivel
            	visivel = true;
                
            }
            
        }
    }else//Se já estiver visivel fica invivisel
    {
        visivel = false;
        	
    }   
}

get_tipo_mundo = function(_mundo)
{
    //Normal
    if (_mundo == "normal") return tipo;

    // invertido
    if (tipo == "parede") return "buraco";
    return "chao";
}



#endregion


