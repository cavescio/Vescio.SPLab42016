<?php 
include "clases/personas.php";
if ( !empty( $_FILES ) ) 
{
    $temporal = $_FILES[ 'file' ][ 'tmp_name' ];
    $ruta = "..". DIRECTORY_SEPARATOR . 'fotos' . DIRECTORY_SEPARATOR . $_FILES[ 'file' ][ 'name' ];
    move_uploaded_file( $temporal, $ruta );
    echo "correcto";
}
if(isset($_GET['accion']))
{
	$accion=$_GET['accion'];
	if($accion=="traer")
	{
		$respuesta= array();
		$respuesta['listado']=personas::TraerTodasLasPersonas();
		$arrayJson = json_encode($respuesta);
		echo  $arrayJson;
	}
}
else{
	$DatosPorPost = file_get_contents("php://input");
	$respuesta = json_decode($DatosPorPost);
	//var_dump($respuesta);
	switch($respuesta->datos->accion)
	{
		case "subirFoto":
		{
			if($respuesta->datos->persona->foto!="pordefecto.png")
			{
				$rutaVieja="../fotos/".$respuesta->datos->persona->foto;
				$rutaNueva=$respuesta->datos->persona->nombre.".".PATHINFO($rutaVieja, PATHINFO_EXTENSION);
				copy($rutaVieja, "../fotos/".$rutaNueva);
				//unlink($rutaVieja);
				$respuesta->datos->persona->foto=$rutaNueva;
				json_encode($rutaNueva);
			}
			break;
		}
		case "insertarUsuario":
		{
			$usuario=new Usuario(0, $respuesta->datos->usuario->mail, $respuesta->datos->usuario->user, $respuesta->datos->usuario->pass);
			$usuario->InsertarUsuario();
			break;
		}
		case "buscarUsuario":
		{
			echo json_encode(Usuario::BuscarUsuario($respuesta->datos->id));
			break;
		}
		case "modificarUsuario":
		{
			$usuario=new Usuario($respuesta->datos->usuario->id, $respuesta->datos->usuario->mail, $respuesta->datos->usuario->user, $respuesta->datos->usuario->pass);
			$usuario->ModificarUsuario();
			break;
		}
	}
		
	}
}
?>