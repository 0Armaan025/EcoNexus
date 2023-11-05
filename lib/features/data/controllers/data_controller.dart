import 'package:econexus/features/authentication/repositories/auth_repository.dart';
import 'package:econexus/features/data/repositories/data_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../authentication/models/eco_projects.dart';

class DataController {
  // controller

  DataRepository repo = DataRepository();

  void addEcoProject(BuildContext context, EcoProjectModel model) {
    repo.addEcoProject(context, model);
  }
}
