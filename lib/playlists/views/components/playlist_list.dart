import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invidious/playlists/states/playlist_list.dart';
import 'package:invidious/utils/models/paginatedList.dart';
import 'package:invidious/playlists/models/playlist.dart';
import 'package:invidious/playlists/views/components/add_to_playlist_list.dart';
import 'package:invidious/playlists/views/components/playlist_in_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../globals.dart';
import '../../../utils/views/components/placeholders.dart';

class PlaylistList extends StatelessWidget {
  final PaginatedList<Playlist> paginatedList;
  final bool canDeleteVideos;
  final String? tag;

  const PlaylistList({super.key, required this.tag, required this.paginatedList, required this.canDeleteVideos});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    AppLocalizations locals = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (BuildContext context) => PlaylistListCubit(PlaylistListState(paginatedList)),
      child: BlocBuilder<PlaylistListCubit, PlaylistListState>(
        builder: (context, _) {
          var cubit = context.read<PlaylistListCubit>();
          bool showPlaceHolder = _.loading && _.playlists.isEmpty;
          return Stack(
            children: [
              _.error.isNotEmpty
                  ? Container(
                      alignment: Alignment.center,
                      color: colorScheme.background,
                      child:
                          Visibility(visible: _.error.isNotEmpty, child: InkWell(onTap: () => cubit.getPlaylists(), child: Text(_.error == couldNotGetPlaylits ? locals.couldntFetchVideos : _.error))),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FadeIn(
                        duration: animationDuration,
                        curve: Curves.easeInOutQuad,
                        child: SmartRefresher(
                          controller: _.refreshController,
                          enablePullDown: _.paginatedList.hasRefresh(),
                          enablePullUp: false,
                          onRefresh: cubit.refreshPlaylists,
                          child: ListView.builder(
                              controller: _.scrollController,
                              itemBuilder: (context, index) =>
                                  index >= _.playlists.length ? const PlaylistPlaceHolder() : PlaylistInList(playlist: _.playlists[index], canDeleteVideos: canDeleteVideos),
                              // separatorBuilder: (context, index) => const Divider(),
                              itemCount: _.playlists.length + (_.loading ? 7 : 0)),
                        ),
                      ),
                    ),
              Visibility(visible: _.loading, child: const SizedBox(height: 1, child: LinearProgressIndicator())),
              const Positioned(bottom: 15, right: 15, child: AddPlayListButton())
            ],
          );
        },
      ),
    );
  }
}