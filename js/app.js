
var app = angular.module('ABMangularPHP', ['ui.router', 'angularFileUpload', 'satellizer'])//esto permite incluir el módulo 'ui.router' al módulo 'ABMangularPHP'
.config(function($stateProvider, $urlRouterProvider, $authProvider)
{
	$authProvider.loginUrl = 'Vescio2P/PHP/clases/Autentificador.php';
	$authProvider.signupUrl = 'Vescio2P/PHP/clases/Autentificador.php';
	$authProvider.tokenName = 'tokenTest';
	$authProvider.tokenPrefix = 'practicapp';
	$authProvider.authHeader = 'data';
	$stateProvider
	.state('menu',
	{url: '/menu',
	templateUrl: 'menu.html',
	controller: 'controlMenu'})
	.state('alta',
	{url: '/alta',
	templateUrl: 'alta.html',
	controller: 'controlAlta'})
	.state('modificacion',
	{url: '/modificacion/{id}?:nombre:apellido:dni:foto',
	templateUrl: 'alta.html',
	controller: 'controlModificacion'})
	.state('grilla',
	{url: '/grilla',
	templateUrl: 'grilla.html',
	controller: 'controlGrilla'})
	.state('login',
	{url: '/login',
	templateUrl: 'login.html',
	controller: 'controlLogin'})
	.state('altaUser',
	{url: '/altaUser',
	templateUrl: 'altaUser.html',
	controller: 'controlAltaUser'})
	.state('modificacionUser',
	{url: '/modificacionUser/?:id',
	templateUrl: 'altaUser.html',
	controller: 'controlModificacionUser'});
	$urlRouterProvider.otherwise('/login');
});

app.controller('controlMenu', function($scope, $http, $auth, $state) {
	if($auth.isAuthenticated())
	{
		console.info($auth.isAuthenticated(), $auth.getPayload());
		$scope.DatoTest="**Menu**";
		$scope.usuario=$auth.getPayload();
		$scope.Logout=function()
		{
			$auth.logout()
			.then(function()
			{
				$state.go("login");
			});
		};
	}
	else{$state.go("login");}
});


app.controller('controlAlta', function($scope, $http, $state, $auth) {
	if($auth.isAuthenticated())
	{
	  $scope.DatoTest="**alta**";


          $scope.producto={};
           $scope.producto.nombre= "linux" ;
           $scope.producto.porcentaje= "12312312" ;

          //EJECUCION DE LA FUNCION 
         // serviceCargadorDeFoto.cargarFoto($scope.persona.foto, $scope.uploader);


          $scope.Guardar=function(){
            //pregunto si el primero elemento de la cola de fotos es igual a 'pordefecto.png'
                    // if ($scope.uploader.queue[0].file.name != 'porDefecto.png') {
                    //   var nombreFoto = $scope.uploader.queue[0].file.name;
                    //   $scope.persona.foto = nombreFoto;
                    // }


                    //cuando la subida de la imagen es success carga la persona
                   // $scope.uploader.onSuccessItem = function(fileItem, response, status, headers) {
                         //console.info('onSuccessItem', fileItem, response, status, headers);


                          $http.post('Datos/productos',$scope.producto)
                          .then(function(respuesta) {       
                               //aca se ejetuca si retorno sin errores        
                               console.log(respuesta.data);

                          },function errorCallback(response) {        
                              //aca se ejecuta cuando hay errores
                              console.log( response);           
                          });



                    



                  //  $scope.uploader.uploadAll();

                  	console.log("producto a guardar:");
                    console.log($scope.producto);
         

          }
	}else{$state.go("login");}
});


app.controller('controlGrilla', function($scope, $http, $state, $auth, FactoryPersona) {
	if($auth.isAuthenticated())
	{
		$scope.DatoTest="**grilla**";

		FactoryPersona.mostrarapellido();

		FactoryPersona.mostrarNombre("otro").then(function(respuesta){

		 $scope.ListadoProductos=respuesta;
 
 	 });
		//$scope.Listadopersonas =factory.fu();
		//$http.get('PHP/nexo.php', { params: {accion :"traer"}})
			$scope.Borrar=function(id){
		console.log("borrar"+id);
       $http.delete('Datos/productos/'+id)
     .then(function(respuesta) {   
    // debugger;    
             //aca se ejetuca si retorno sin errores        
             console.log(respuesta.data);

            $http.get('Datos/productos')
            .then(function(respuesta) {       

                   $scope.ListadoProductos = respuesta.data;
                   console.log(respuesta.data);

              },function errorCallback(response) {
                   $scope.ListadoProductos= [];
                  console.log( response);

      });

        },function errorCallback(response) {        
            //aca se ejecuta cuando hay errores
            console.log( response);           
        });


 	}
	}else{$state.go("login");}

});
app.controller('controlModificacion', function($scope, $http, $state, $stateParams, $auth, FileUploader, cargadordefotos, ServicePersona)//, $routeParams, $location)
{
	if($auth.isAuthenticated())
	{
		$scope.persona={};
		$scope.DatoTest="**Modificar**";
		$scope.uploader=new FileUploader({url:'PHP/nexo.php'});
		console.log($stateParams);
		$scope.persona.id=$stateParams.id;
		$scope.persona.nombre=$stateParams.nombre;
		$scope.persona.apellido=$stateParams.apellido;
		$scope.persona.dni=$stateParams.dni;
		$scope.persona.foto=$stateParams.foto;
		console.log($scope.persona);
		cargadordefotos.cargarfoto($scope.persona.foto, $scope.uploader);
		$scope.persona.foto = $http.post('PHP/nexo.php', { accion:"subirFoto",persona:$scope.persona});
		
		$scope.uploader.onSuccessItem=function(item, response, status, headers)
	{
		//$http.post('PHP/nexo.php', { datos: {accion :"modificar",persona:$scope.persona}})
		ServicePersona.Modificacion($scope.persona)
		.then(function(respuesta) {     	
				 $state.go("grilla");
		});
		/*$http.put('slim2/persona/',{persona:$scope.persona})
		.then(function(respuesta) 
		{	//aca se ejetuca si retorno sin errores      	
			console.log(respuesta.data);
			$state.go("grilla");
		},
		function errorCallback(response)
		{	//aca se ejecuta cuando hay errores
			console.log( response);     			
		});*/
		console.info("Ya guardé el archivo.", item, response, status, headers);
	};
	$scope.Guardar=function(persona)
	{
		if($scope.uploader.queue[0]!=undefined)
		{
			var nombrefoto = $scope.uploader.queue[0]._file.name;
			$scope.persona.foto=nombrefoto;
		}
		$scope.uploader.uploadAll();
		//$http.put('slim2/persona/',{persona:$scope.persona})
		ServicePersona.Modificacion($scope.persona)
		.then(function(respuesta) {     	
				$state.go("grilla");
		});
		//$http.post('PHP/nexo.php', { datos: {accion :"modificar",persona:$scope.persona}})
		/*.then(function(respuesta) 
		{
			//aca se ejetuca si retorno sin errores      	
			console.log(respuesta.data);
			$state.go("grilla");
		},
		function errorCallback(response)
		{
			//aca se ejecuta cuando hay errores
			console.log( response);     			
		});*/
	}
	}else{$state.go("login");}
});//////CIERRA EL CONTROL MODIFICACION///////
//////////////////////////////////////////////


app.controller('controlLogin', function($scope, $http, $auth, $state)
{
	$scope.mail="comp@comp.com";
	$scope.user="comprador";
	$scope.pass="123";
	if($auth.isAuthenticated())
	{
		$state.go("menu");
	}
	else
	{
		$scope.DatoTest="**Iniciar Sesión**";
		$scope.Login=function()
		{
			$auth.login({user:$scope.user, pass:$scope.pass})
			.then(function(respuesta)
			{
				console.log(respuesta);
				if($auth.isAuthenticated())
				{
					console.info($auth.isAuthenticated(), $auth.getPayload());
					$state.go("grilla");
				}
				else
				{
					alert("No se encontró el usuario. Verifique los datos.");
				}
			});
		};
		$scope.CargarFormulario=function()
		{
			$state.go("altaUser");
		};
	}
});
app.controller('controlAltaUser', function($scope, $http, $auth, $state)
{
	if($auth.isAuthenticated())
	{
		$state.go("menu");
	}
	else
	{
		$scope.usuario={};
		$scope.dni="Crear Cuenta";
		$scope.GuardarDatos=function()
		{
			if($scope.usuario.mail!=undefined && $scope.usuario.user!=undefined && $scope.usuario.pass!=undefined && $scope.usuario.mail!="" && $scope.usuario.user!="" && $scope.usuario.pass!="")
			{
				$http.post('PHP/nexo.php', {datos:{accion:"insertarUsuario", usuario:$scope.usuario}})
				.then(function(respuesta)
				{
					$state.go("login");
				},
				function errorCallback(response)
				{
					//aca se ejecuta cuando hay errores
					console.log( response);     			
				});
			}
			else
			{
				alert("No puede ingresar datos vacíos.");
			}
		}
	}
});
app.controller('controlModificacionUser', function($scope, $http, $auth, $state, $stateParams)
{
	if($auth.isAuthenticated())
	{
		console.log($stateParams);
		$scope.usuario={};
		$scope.dni="Modificar Datos";
		$scope.bloquear=true;
		$http.post('PHP/nexo.php', {datos:{accion:"buscarUsuario", id:$stateParams.id}})
		.then(function(respuesta)
		{
			$usuario=respuesta.data[0];
			$scope.usuario.id=$usuario.id;
			$scope.usuario.mail=$usuario.mail;
			$scope.usuario.user=$usuario.user;
			$scope.usuario.pass=$usuario.pass;
		},
		function errorCallback(response)
		{
			//aca se ejecuta cuando hay errores
			console.log( response);     			
		});
		$scope.GuardarDatos=function()
		{
			if($scope.usuario.mail!="" && $scope.usuario.user!="" && $scope.usuario.pass!="")
			{
				$http.post('PHP/nexo.php', {datos:{accion:"modificarUsuario", usuario:$scope.usuario}})
				.then(function(respuesta)
				{
					$state.go("menu");
				},
				function errorCallback(response)
				{
					//aca se ejecuta cuando hay errores
					console.log( response);     			
				});
			}
			else
			{
				alert("No puede ingresar datos vacíos.");
			}
		}
	}
	else
	{
		$state.go("menu");
	}
});





///////////////////////////////////////////
//////// Servicios/////////////////////////
///////////////////////////////////////////
//ARRANCA SERCVIOS Y FACTORY
app.factory('FactoryPersona', function(ServicioUsuario){
  var persona = {
   
    mostrarNombre:function(dato){
      
     return ServicioUsuario.retornarUsuarios().then(function(respuesta){
       
        return respuesta;
      });
    },
    mostrarapellido:function(){
    	console.log("soy otra funcion de factory");
    }
}
  return persona;

});

//Siguen a un patrón Singleton
app.service('ServicioUsuario', function($http){
  var listado;

  this.retornarUsuarios = function(){

       return $http.get('Datos/productos')
                    .then(function(respuesta) 
                    {     
                    //  console.log(respuesta.data);
                      return respuesta.data;
                    });
                  };

                  //return listado;
});
