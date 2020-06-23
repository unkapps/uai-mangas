import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leitor_manga/chapter/chapter_readed/bloc/chapter_readed_bloc.dart';
import 'package:leitor_manga/user/login_dialog.dart';

class ChapterReaded extends StatelessWidget {
  final int chapterId;
  final bool readed;

  ChapterReaded({Key key, @required this.chapterId, @required this.readed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChapterReadedBloc>(
      create: (context) {
        return ChapterReadedBloc(chapterId)
          ..add(ChapterReadedLoadedEvent(readed));
      },
      child: BlocBuilder<ChapterReadedBloc, ChapterReadedState>(
        builder: (BuildContext context, ChapterReadedState state) {
          if (state is ChapterReadedLoading) {
            return Container(
              width: 24,
              height: 24,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is ChapterReadedLoaded) {
            return _buildReaded(context, readed: state.readed);
          }

          if (state is ChangeChapterReadedError) {
            return _buildReaded(context, readed: state.oldReaded);
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildReaded(
    BuildContext context, {
    bool authenticated = true,
    bool readed = false,
  }) {
    var theme = Theme.of(context);
    var icon = readed ? Icons.check_circle : Icons.check_circle_outline;

    var color = theme.disabledColor;

    if (readed) {
      color = theme.accentColor;
    }

    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: 24,
          color: color,
        ),
        onPressed: () {
          if (authenticated) {
            context
                .bloc<ChapterReadedBloc>()
                .add(ChangeChapterReadedEvent(!readed));
          } else {
            LoginDialog.createAndShowDialog(context);
          }
        },
      ),
    );
  }
}
