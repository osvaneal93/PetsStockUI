
CREAR DISENIO
appbar: subir imagen, tomar foto, volver
cuerpo: form, column, textForm - producto y precio (keyboard), button

validators
-texto
-numerico, utils, notempty, intentar pasear, return false or true,validators con los utils, boton y keys global, validar formulario currentstate.validate, colocar si formulario no es valido.

modelo: id, titulo, valor, disponible, fotourl
conectar con el modelo, poner valores iniciales en textform,  guardar con on saved, ejecutar saved con currentstate, switchListTile para el stock

preparar firebase

creamos el provider -url - metodo crearP, el resp swra el await de http.post, a firebae se manda string por lo que usamos productoModeltojson, decodificamos.

llevamos provider a la pag de productos y ejecutamos en el boton.

MOSTRAR PRODUCTOS
metodo en el provider get devuelve future list model, dibujamos en la pagina home con un futureB, pero antes aplicamos el for each para poder mostrar la lista.

foreach sacamos del decodedD, producto temp que va a ser modelo fromJson, cambiamos el id del prodt por el index, add a una lista creada desp del decoded retornamos prod.

retornamos listviewbuilder en el future.
el itembuilder sera en un metodo aparte, el cual returna listTile con los datos del modelo que recibe el metodo, envolver listtile en undismiss, colocar key.

creamos metodo delete, utilizamos el id para borrar de firebase.
lo mandamos al onDismissible.

creamos le metodo update con el put, y id de producto. Muy parecido a Add. Le mandamos lo sdatos del producto desde el listTile por medio de arguments, y otra pag recuperamos con modalroute y le otorgamos los args recibidos a el model de ahi. Despues en el boton guardar verifiacion si id es distinto o igal  null. Quitamos el guardar duplicado id

creamos un snackbar en metodo a parte, sera una estancia final, crear nuevo key para scaffold, invocar en el mismo metodo con currentS. Bloquear boton evita rdoble subida, estancia bool en false, en submit hacemos los cambios a true mediante setS y false antes y despu'es de grabar datos, en el on press evaluamos la condicion de el booleano creado.

CARGAR IMAGENES
libreria image picker
sdk android
creamos metodos para appbar
p selecc foto creamos estancia d imagepicker, imagesource, validamos que no sean null la imag, redibujamos con setstate, creamos metodo para mostrar foto con condicion si foto.url es null,  regresamos imagen con condicion foto?.path?? 'assetsImage'.

convertir el metodo para que sea cargar imagen y tomar foto.

Configurar cloudinary y probar en postman
crear metodo en provider, recibe file, devuelve f string,

creamos el uri,
creamos mimetype usando el mimetype = mime (image.path)usar .split /
el request sera multipartrequ, post, url.
creamos el file con await multipartfil.frompat(file, path, mediatype ) 

 en el metodo submit vamos a guardar en una nueva estancia el enlace de donde se guardo la foto, si foto es distinto de null al modelo.fotourl le ponemos el string que devuelve el metodo de subir imagen.

 Creamos el disenio que vamos a mostrar en el list
 podemos utilizar ternario si producto.fotourl es null mostramos not image, sino pues ya cargamos el networkImage.
En el mostrarFoto de el archivo pra cargar el producto en el todo if regresamos un fadeimage con el network de la imagen

En el procesar foto, usmos el if foto es != null entonces lo hacemos == a null para que se pueda llevar a cabo la carga de la nueva imagen 