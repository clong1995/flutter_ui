import 'package:nio/src/base.dart';

class EmptyReq extends BaseReq {}

class EmptyRes extends BaseRes {
  @override
  void fromJson() {}
}
