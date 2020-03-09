
import 'package:flutter/material.dart';
import 'package:forms_crud_app/src/blocs/provider.dart';
import 'package:forms_crud_app/src/models/producto_model.dart';
import 'package:forms_crud_app/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  final productosProvider = ProductosProvider();


  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: AppBar(
        title: Text('List of Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){}
          )
        ],
      ),
      body: _crearListadoProductos(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Navigator.pushNamed(context, 'producto');
      },
    );
  }

  Widget _crearListadoProductos() {

    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if( snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: AlignmentDirectional.centerStart,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
          child: Icon(Icons.delete_forever, color: Colors.white,),
        ),
      ),
      onDismissed: (direccion) {
        print(direccion);
        productosProvider.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ( producto.fotoUrl == null )
              ? Image(image: AssetImage('assets/original.png'))
              : FadeInImage(
              image: NetworkImage(producto.fotoUrl),
              placeholder: AssetImage('assets/original.gif'),
              height: 250.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text(producto.id),
              onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),
            )
          ],
        ),
      ),
    );
  }

}
