import 'package:flutter/material.dart';
import '../callApi/get_actors.dart';
import '../models/actor.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({required this.actor, Key? key}) : super(key: key);

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.pushNamed(context, "/edit_actor", arguments: actor),
      title: Text(actor.name,
          style: const TextStyle(fontSize: 22, color: Colors.black))
    );
  }
}

class AdminActorList extends StatefulWidget {
  AdminActorList({Key? key}) : super(key: key);

  @override
  State<AdminActorList> createState() => _AdminActorListState();
}

class _AdminActorListState extends State<AdminActorList> {
  List<Actor> _actors = [];

  void getAllActors() async {
    List<Actor>? response = await getActors();
    if (response != null) {
      setState(() {
        _actors = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getAllActors();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Список актёров"),
              centerTitle: true,
            ),
            body: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 2,
                ),
                itemCount: _actors.length,
                padding: const EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return ActorCard(actor: _actors[index]);
                }),
            floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    child: Icon(
                        Icons.person_add
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(context, '/add_actor'),
                    heroTag: null,
                  )
                ]
            )
        ),
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, '/admin_list_films');
          return Future.value(true);
        }
    );
  }
}
