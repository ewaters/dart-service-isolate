import 'package:build/build.dart';

import 'src/builder.dart';

Builder getBuilder(BuilderOptions options) => ServiceIsolateBuilder(options);
