<%-- 
    Document   : libros
    Created on : 9/11/2021, 08:28:12 AM
    Author     : fido
--%>

<%@page import="logica.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <title>Libros</title>
        <!--<style>div{border: dotted;}</style>-->
    </head>
    <body>
        <%
        Usuario u = (Usuario)session.getAttribute("usuario");
        if(u!=null){
        %>
        <jsp:include page="menu.jsp"/>
        <div class="container-fluid" ng-app="libros" ng-controller="librosController as lib">
            <div class="row mt-2">
                <div class="col-10"><h2>Bienvenido/a: <%=u.getNombreDeUsuario()%></h2></div>
                <div class="col-2"><button type="button" class="btn btn-outline-danger btn-block" ng-click="lib.cerrarSesion()">Cerrar sesion</button></div>
            </div>
            <div class="row">
                <!--seccion 1-->
                <div class="col-6">
                    <div class="row">
                        <div class="col-6">
                            <label>Isbn</label>
                            <input type="text" class="form-control" ng-model="lib.isbn">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" ng-model="lib.nombre">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Numero de paginas</label>
                            <input type="number" class="form-control" ng-model="lib.numeroDePaginas">
                        </div>
                        <div class="col-6">
                            <label>Año</label>
                            <input type="number" class="form-control" ng-model="lib.annio">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Categoria</label>
                            <select class="form-control" ng-model="lib.categoria">
                                <option ng-repeat="c in lib.Categorias" value="{{c.id}}">{{c.nombre}}</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label>Autor</label>
                            <select class="form-control" ng-model="lib.autor">
                                <option ng-repeat="a in lib.Autores" value="{{a.codigo}}">{{a.nombre}}</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-3">
                            <button type="button" class="btn btn-success" ng-click="lib.guardar()">Guardar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-primary" ng-click="lib.listar()">Listar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-warning" ng-click="lib.actualizar()">Actualizar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#eliminarModal">Eliminar</button>
                        </div>
                    </div>
                </div>
                <!--seccion 2-->
                <div class="col-6">
                    <div class="row">
                        <div class="col-6">
                            <label>Isbn</label>
                            <input type="text" class="form-control" disabled="" value="{{lib.isbn}}">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" disabled="" value="{{lib.nombre}}">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Numero de paginas</label>
                            <input type="text" class="form-control" disabled="" value="{{lib.numeroDePaginas}}">
                        </div>
                        <div class="col-6">
                            <label>Año</label>
                            <input type="text" class="form-control" disabled="" value="{{lib.annio}}">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Codigo categoria</label>
                            <input type="text" class="form-control" disabled="" value="{{lib.categoria}}">
                        </div>
                        <div class="col-6">
                            <label>Codigo autor</label>
                            <input type="text" class="form-control" disabled="" value="{{lib.autor}}">
                        </div>
                    </div>
                </div>
            </div>
            <!--seccion 3-->
            <div class="row mt-2">
                <div class="col-12">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Isbn</th>
                                <th scope="col">Nombre</th>
                                <th scope="col"># paginas</th>
                                <th scope="col">Año</th>
                                <th scope="col">Categoria</th>
                                <th scope="col">Autor</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="l in lib.Libros">
                                <td>{{l.isbn}}</td>
                                <td>{{l.nombre}}</td>
                                <td>{{l.numeroDePaginas}}</td>
                                <td>{{l.annio}}</td>
                                <td>{{l.categoria.nombre}}</td>
                                <td>{{l.autor.nombre}}</td>
                                <td>
                                    <button type="button" class="btn btn-info" ng-click="lib.editar(l.isbn)">Editar</button>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
            <!-- Modal eliminar-->
            <div class="modal fade" id="eliminarModal" tabindex="-1" aria-labelledby="eliminarModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="eliminarModalLabel">¿Está seguro de eliminar ese registro?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            El registro será eliminado completamente de la base de datos
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="lib.eliminar()">SI</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            var app = angular.module('libros', []);
            app.controller('librosController', ['$http', controladorLibros]);
            function controladorLibros($http) {
                var lib = this;
                consultarCategorias = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesCategoria.jsp',
                        params: parametros
                    }).then(function (res) {
                        lib.Categorias = res.data.Categorias;
                    });
                };
                consultarAutores = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesAutor.jsp',
                        params: parametros
                    }).then(function (res) {
                        lib.Autores = res.data.Autores;
                    });
                };
                consultarCategorias();//llamar la funcion, se ejecuta al cargar la pagina
                consultarAutores();
                validar = function (tipoDeValidacion) {
                    var isbn = lib.isbn ? true : false;
                    var nombre = lib.nombre ? true : false;
                    var numeroDePaginas = lib.numeroDePaginas ? true : false;
                    var annio = lib.annio ? true : false;
                    var autor = lib.autor ? true : false;
                    var categoria = lib.categoria ? true : false;
                    if (tipoDeValidacion === 'todosLosCampos') {
                        if (isbn && nombre && numeroDePaginas && annio && autor && categoria) {
                            return true;
                        } else {
                            return false;
                        }
                    } else if (tipoDeValidacion === 'soloIsbn') {
                        if (isbn) {
                            return true;
                        } else {
                            return false;
                        }
                    } else {
                        return false;
                    }
                };

                lib.listar = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        lib.Libros = res.data.Libros;
                    });
                };
                lib.guardar = function () {
                    if (validar('todosLosCampos')) {
                        var parametros = {
                            proceso: 'guardar',
                            isbn: lib.isbn,
                            nombre: lib.nombre,
                            numeroDePaginas: lib.numeroDePaginas,
                            annio: lib.annio,
                            idCategoria: lib.categoria,
                            codigoAutor: lib.autor
                        };
                        $http({
                            method: 'POST',
                            url: 'peticionesLibro.jsp',
                            params: parametros
                        }).then(function (res) {
                            if (res.data.ok === true) {
                                if (res.data.guardar === true) {
                                    swal({
                                        title: "Guardó",
                                        text: "El registro fue guardado exitosamente",
                                        icon: "success",
                                        button: "cerrar"
                                    });
                                } else {
                                    swal({
                                        title: "No guardó",
                                        text: "El registro no fue guardado exitosamente",
                                        icon: "error",
                                        button: "cerrar"
                                    });
                                }
                            } else {
                                swal({
                                    title: "Falló",
                                    text: res.data.errorMsg,
                                    icon: "error",
                                    button: "cerrar"
                                });
                            }
                        });
                    } else {
                        swal({
                            title: "Verificar Campos",
                            text: "todos los campos son obligatorios",
                            icon: "warning",
                            button: "cerrar"
                        });
                    }
                };
                lib.actualizar = function () {
                    if (validar('todosLosCampos')) {
                        var parametros = {
                            proceso: 'actualizar',
                            isbn: lib.isbn,
                            nombre: lib.nombre,
                            numeroDePaginas: lib.numeroDePaginas,
                            annio: lib.annio,
                            idCategoria: lib.categoria,
                            codigoAutor: lib.autor
                        };
                        $http({
                            method: 'POST',
                            url: 'peticionesLibro.jsp',
                            params: parametros
                        }).then(function (res) {
                            if (res.data.ok === true) {
                                if (res.data.actualizar === true) {
                                    swal({
                                        title: "Ejecutó",
                                        text: "El registro fue actualizado exitosamente",
                                        icon: "success",
                                        button: "cerrar"
                                    });
                                } else {
                                    swal({
                                        title: "No ejecutó",
                                        text: "El registro no fue actualizado exitosamente",
                                        icon: "error",
                                        button: "cerrar"
                                    });
                                }
                            } else {
                                swal({
                                    title: "Falló",
                                    text: res.data.errorMsg,
                                    icon: "error",
                                    button: "cerrar"
                                });
                            }
                        });
                    } else {
                        swal({
                            title: "Verificar Campos",
                            text: "todos los campos son obligatorios",
                            icon: "warning",
                            button: "cerrar"
                        });
                    }
                };
                lib.eliminar = function () {
                    if (validar('soloIsbn')) {
                        var parametros = {
                            proceso: 'eliminar',
                            isbn: lib.isbn
                        };
                        $http({
                            method: 'POST',
                            url: 'peticionesLibro.jsp',
                            params: parametros
                        }).then(function (res) {
                            if (res.data.ok === true) {
                                if (res.data.eliminar === true) {
                                    swal({
                                        title: "Ejecutó",
                                        text: "El registro fue eliminado exitosamente",
                                        icon: "success",
                                        button: "cerrar"
                                    });
                                } else {
                                    swal({
                                        title: "No ejecutó",
                                        text: "El registro no fue eliminado exitosamente",
                                        icon: "error",
                                        button: "cerrar"
                                    });
                                    
                                }
                            } else {
                                swal({
                                    title: "Falló",
                                    text: res.data.errorMsg,
                                    icon: "error",
                                    button: "cerrar"
                                });
                            }
                        });
                    } else {
                        swal({
                            title: "Verificar Campos",
                            text: "El isbn es obligatorio",
                            icon: "warning",
                            button: "cerrar"
                        });
                    }
                };
                lib.editar = function (isbnP) {
                    var parametros = {
                        proceso: 'consultarIndividual',
                        isbn: isbnP
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        lib.isbn = res.data.Libro.isbn;
                        lib.nombre = res.data.Libro.nombre;
                        lib.numeroDePaginas = res.data.Libro.numeroDePaginas;
                        lib.annio = res.data.Libro.annio;
                        lib.autor = res.data.Libro.autor.codigo;
                        lib.categoria = res.data.Libro.categoria.id.toString();

                    });
                };
                
                 lib.cerrarSesion = function () {
                    var parametros = {
                        proceso: 'cerrarSesion'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLogin.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            window.location.href="libros.jsp";
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };

            }
        </script>
        <%}else{%>
        <center><a href="index.jsp">La sesion caducó o no se ha iniciado sesion click acá para ingresar</a></center>
        <%}%>
    </body>
    <jsp:include page="footer.jsp"/>
</html>
