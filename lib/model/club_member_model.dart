import 'package:dropout/helper/imports/common_import.dart';
import 'package:dropout/model/user_model.dart';

class ClubMemberModel {
  int id = 0;
  int clubId = 0;
  int userId = 0;
  int isAdmin = 0;
  UserModel? user;

  ClubMemberModel();

  factory ClubMemberModel.fromJson(dynamic json) {
    ClubMemberModel model = ClubMemberModel();
    model.id = json['id'];
    model.clubId = json['club_id'];
    model.userId = json['user_id'];
    model.isAdmin = json['is_admin'];
    model.user = UserModel.fromJson(json['user']);

    return model;
  }
}
