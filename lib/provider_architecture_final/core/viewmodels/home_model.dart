import 'package:test_bed/provider_architecture_final/core/enums/viewstate.dart';
import 'package:test_bed/provider_architecture_final/core/models/post.dart';
import 'package:test_bed/provider_architecture_final/core/services/api.dart';
import 'package:test_bed/provider_architecture_final/locator.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  Api _api = locator<Api>();

  List<Post> posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    posts = await _api.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}