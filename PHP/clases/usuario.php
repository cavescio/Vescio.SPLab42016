<?php
	require_once("conexion.php");
	class usuario
	{
		public $id;
		public $mail;
		public $user;
		public $pass;
		public $tipo;
		public $foto;


		public function __construct($id, $mail, $user, $pass, $tipo, $foto)
		{
			$this->id=$id;
			$this->mail=$mail;
			$this->user=$user;
			$this->pass=$pass;
			$this->tipo="empleado";
			$this->foto=$foto;
		}
		public static function ToArray()
		{
			$conexion=Conexion::AccederDatos();
			$sentencia=$conexion->Prepare("SELECT * FROM usuario");
			$sentencia->Execute();
			$usuarios=$sentencia->fetchAll(PDO::FETCH_ASSOC);
			$conexion=null;
			return $usuarios;
		}
		public static function BuscarUsuario($id)
		{
			$conexion=Conexion::AccederDatos();
			$sentencia=$conexion->Prepare("SELECT * FROM usuario WHERE id=:id");
			$sentencia->bindValue(":id", $id, PDO::PARAM_INT);
			$sentencia->Execute();
			$usuario=$sentencia->fetchAll(PDO::FETCH_ASSOC);
			$conexion=null;
			return $usuario;
		}
		public function InsertarUsuario()
		{
			$conexion=Conexion::AccederDatos();
			$sentencia=$conexion->Prepare("INSERT INTO usuario(mail, user, pass, tipo, foto) VALUES (:mail, :user, :pass, :tipo, :foto)");
			$sentencia->bindValue(":mail", $this->_mail, PDO::PARAM_STR);
			$sentencia->bindValue(":user", $this->_user, PDO::PARAM_STR);
			$sentencia->bindValue(":pass", $this->_pass, PDO::PARAM_STR);
			$sentencia->bindValue(":tipo", $this->_tipo, PDO::PARAM_STR);
			$sentencia->bindValue(":foto", $this->_foto, PDO::PARAM_STR);
			$sentencia->Execute();
			$conexion=null;
		}
		public function ModificarUsuario()
		{
			$conexion=Conexion::AccederDatos();
			$sentencia=$conexion->Prepare("UPDATE usuario SET mail=:mail, user=:user, pass=:pass, tipo=:tipo, foto=:foto WHERE id=:id");
			$sentencia->bindValue(":id", $this->_id, PDO::PARAM_INT);
			$sentencia->bindValue(":mail", $this->_mail, PDO::PARAM_STR);
			$sentencia->bindValue(":user", $this->_user, PDO::PARAM_STR);
			$sentencia->bindValue(":pass", $this->_pass, PDO::PARAM_STR);
			//$sentencia->bindValue(":tipo", $this->_pass, PDO::PARAM_STR);
			$sentencia->bindValue(":tipo", $this->_tipo, PDO::PARAM_STR);
			$sentencia->bindValue(":foto", $this->_foto, PDO::PARAM_STR);
			$sentencia->Execute();
			$conexion=null;
		}
		public static function EliminarUsuario($id)
		{
			$conexion=Conexion::AccederDatos();
			$sentencia=$conexion->Prepare("DELETE FROM usuario WHERE id=:id");
			$sentencia->bindValue(":id", $id, PDO::PARAM_INT);
			$sentencia->Execute();
			$conexion=null;
		}
//********************Geters y Seters*******************
		public function getId()
		{
			return $this->id;
		}

		public function getTipo()
		{
			return $this->tipo;
		}

		public function getFoto()
		{
			return $this->foto;
		}

		public function getMail()
		{
			return $this->mail;
		}
		public function getUser()
		{
			return $this->user;
		}
		public function getPass()
		{
			return $this->pass;
		}
		public function setId($value)
		{
			$this->id=$value;
		}
		public function setMail($value)
		{
			$this->mail=$value;
		}
		public function setUser($value)
		{
			$this->user=$value;
		}
		public function setPass($value)
		{
			$this->pass=$value;
		}

		public function setTipo($value)
		{
			$this->tipo=$value;
		}

		public function setFoto($value)
		{
			$this->foto=$value;
		}
		
	}
?>