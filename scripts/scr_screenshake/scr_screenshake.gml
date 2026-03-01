//Função de screenshake
function tremer(_valor = 10)
{
	if(instance_exists(obj_screenshake))
	{
		with(obj_screenshake)
		{
			
			//Se o valor novo for maior do que a tremida atual
			//Ele substitui pelo valor novo, caso contrário não
			//Dessa forma só temos uma tremida nova na tela
			//Se o objeto que fizer tremer for mais "importante"
			//o efeito do que o do valor que estiver rodando
			if(_valor > treme)
			{
				treme = _valor;
				
			}	
			
		}	
		
		
	}	
	
}	