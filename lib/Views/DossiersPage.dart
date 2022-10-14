import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../Models/ProspectModel.dart';
import 'PhotoViewPage.dart';

class DossiersPage extends StatefulWidget {
  DossiersPage({required this.clientrecup});

  ProspectModel clientrecup;

  @override
  State<DossiersPage> createState() =>
      _DossiersPageState(clientrecup: clientrecup);
}

class _DossiersPageState extends State<DossiersPage> {
  ProspectModel clientrecup;

  _DossiersPageState({required this.clientrecup});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dossiers du prospect"),
          elevation: 0,
          backgroundColor: Colors.deepOrange,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Images",
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(Icons.browse_gallery_outlined, color: Colors.white),
              ),
              Tab(
                child: Text(
                  "Documents",
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.document_scanner,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [ZoneImg(widget.clientrecup), ZoneDoc(widget.clientrecup)],
        ),
      ),
    );
  }

  ZoneImg(clientrecup) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(child: listImagesVue(context, clientrecup)),
        ],
      ),
    );
  }

  ZoneDoc(clientrecup) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(child: listDocumentsVue(context, clientrecup)),
        ],
      ),
    );
  }

  listImagesVue(BuildContext context, clientrecup) {
    return RefreshIndicator(
      onRefresh: () async {
        // effectuer une action asynchrone
        await Future.delayed(
            Duration(milliseconds: 800)); // simuler une action asynchrone

        setState(() {});
      },
      child: GridView.builder(
        itemCount: clientrecup.piecesjointes.length,
        itemBuilder: (BuildContext context, int index) {
          var img = clientrecup.piecesjointes[index].path;
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PhotoviewPage(
                          position: index,
                          listimage: clientrecup.piecesjointes,
                        ))),
            child: CachedNetworkImage(
              imageUrl: "$img",
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
      ),
    );
  }

  listDocumentsVue(BuildContext context, clientrecup) {
    return RefreshIndicator(
      onRefresh: () async {
        // effectuer une action asynchrone
        await Future.delayed(
            Duration(milliseconds: 800)); // simuler une action asynchrone

        setState(() {});
      },
      child: ListView.builder(
        itemCount: clientrecup.piecesjointes.length,
        itemBuilder: (BuildContext context, int index) {
          var doc = clientrecup.piecesjointes[index];
          var completePath = doc.path;
          var fileName = (completePath.split('./').last);
          var fileExtension = (fileName.split("/").last);
          return ListTile(
            onTap: () {
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.showSnackBar(SnackBar(
                content: Text("J'ai cliqué sur $doc"),
                action: SnackBarAction(
                    label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
              ));
            },
            leading: Text(
              fileExtension,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            title: Text(
              fileName,
              //overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}
