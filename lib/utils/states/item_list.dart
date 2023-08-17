import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:invidious/settings/models/errors/invidiousServiceError.dart';
import 'package:invidious/utils.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/paginatedList.dart';

part 'item_list.g.dart';

enum ItemListErrors { none, couldNotFetchItems, invalidScope }

var log = Logger('ItemListCubit');

class ItemListCubit<T> extends Cubit<ItemListState<T>> {
  ItemListCubit(super.initialState) {
    onReady();
  }

  @override
  close() async {
    state.refreshController.dispose();
    state.scrollController.dispose();
    super.close();
  }

  onReady() {
    getItems();
    state.scrollController.addListener(onScrollEvent);
  }

  onScrollEvent() {
    if (state.scrollController.hasClients) {
      if (state.scrollController.position.maxScrollExtent * 0.9 < state.scrollController.offset) {
        EasyDebounce.debounce('loading-more-videos', const Duration(milliseconds: 500), getMoreItems);
      }
    }
  }

  getMoreItems() async {
    if (!state.loading && state.itemList.getHasMore()) {
      loadItems(() async {
        List<T> items = await state.itemList.getMoreItems();
        List<T> currentItems = state.items;
        currentItems.addAll(items);
        return currentItems;
      });
    }
  }

  refreshItems() async {
    loadItems(state.itemList.refresh);
  }

  getItems() async {
    loadItems(state.itemList.getItems);
  }

  loadItems(Future<List<T>> Function() refreshFunction) async {
    var state = this.state.copyWith();
    // var locals = AppLocalizations.of(context)!;
    state.error = ItemListErrors.none;
    state.loading = true;
    emit(state);
    try {
      state = this.state.copyWith();
      state.items = await refreshFunction();
      ;
      state.loading = false;
      emit(state);
    } catch (err) {
      state = this.state.copyWith();
      state.items = [];
      state.loading = false;
      if (err is InvidiousServiceError && err.message == "Invalid scope") {
        state.error = ItemListErrors.invalidScope;
      } else {
        state.error = ItemListErrors.couldNotFetchItems;
      }
      emit(state);
      rethrow;
    }
    state.refreshController.refreshCompleted();
  }

  // similar
  focusChanged(bool value, int index) {}
}

@CopyWith(constructor: "_")
class ItemListState<T> {
  static ItemListState? to(String? tags) => safeGet(tag: tags);

  PaginatedList<T> itemList;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  List<T> items = [];
  bool loading = true;
  Map<String, Image> imageCache = {};
  ScrollController scrollController = ScrollController();
  ItemListErrors error = ItemListErrors.none;

  ItemListState({required this.itemList}) {}

  ItemListState._(this.itemList, this.refreshController, this.items, this.loading, this.imageCache, this.scrollController, this.error);
}