import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';
import 'package:meta/meta.dart';

part 'manga_single_event.dart';
part 'manga_single_state.dart';

class MangaSingleBloc extends Bloc<MangaSingleEvent, MangaSingleState> {
  static final getIt = GetIt.instance;
  final MangaService service = getIt<MangaService>();

  final int mangaId;

  MangaSingleBloc(this.mangaId) : super(MangaSingleLoading());

  @override
  Stream<MangaSingleState> mapEventToState(
    MangaSingleEvent event,
  ) async* {
    if (event is LoadMangaSingleEvent) {
      yield MangaSingleLoading();

      try {
        var manga = await service.getManga(mangaId);

        if (manga == null) {
          yield MangaSingle404();
        } else {
          yield MangaSingleLoaded(manga);
        }
      } catch (_) {
        yield MangaSingleError();
      }
    }
  }
}
