
import 'package:flutter/material.dart';

class MineProvider extends ChangeNotifier {
    BuildContext context;
    
    MineProvider(this.context);
    var scaffoldkey = GlobalKey<ScaffoldState>();
      
    bool _initialized = false;
      
    void init() {
        if (!_initialized) {
            _initialized = true;
            Future.delayed(const Duration(milliseconds: 100), () {
                
            });
        }
    }
}
