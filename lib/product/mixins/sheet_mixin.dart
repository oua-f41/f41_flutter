import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class _CustomSheet extends StatelessWidget {
  final Widget child;
  final VoidCallback? done;

  const _CustomSheet({required this.child, required this.done});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: context.isKeyBoardOpen
          ? const EdgeInsets.fromLTRB(0, 100, 0, 0)
          : const EdgeInsets.fromLTRB(0, 350, 0, 0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
/*       color: _backgroundColor, */
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [_CustomSheetTop(done: done), Expanded(child: child)],
        ),
      ),
    );
  }
}

class _CustomSheetTop extends StatelessWidget {
  const _CustomSheetTop({
    Key? key,
    required this.done,
  }) : super(key: key);

  final VoidCallback? done;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      done != null
          ? Positioned(
              top: -5,
              right: 0,
              child: Container(
                child: TextButton(
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: () {
                    done!();
                  },
                ),
              ))
          : const SizedBox(),
      Positioned(
          left: done != null ? 0 : null,
          right: done != null ? null : 0,
          top: -5,
          child: Container(
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.pop();
              },
              alignment: Alignment.topCenter,
            ),
          )),
      Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Divider(
          color: Colors.black45,
          thickness: 3,
          indent: MediaQuery.of(context).size.width * 0.4,
          endIndent: MediaQuery.of(context).size.width * 0.4,
        ),
      ),
    ]);
  }
}

mixin CustomSheetMixin {
  Future<T?> showCustomSheet<T>(
      {required BuildContext context,
      required Widget child,
      VoidCallback? done}) async {
    showModalBottomSheet<T>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        context: context,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
        builder: (context) {
          return _CustomSheet(done: done, child: child);
        });
    return null;
  }
}
