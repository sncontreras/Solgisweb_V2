import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/helpers/signin_credentials.dart';
import 'package:solgis/core/domain/providers/home_provider.dart';
import 'package:solgis/core/presentation/pages/login/widgets/widget.dart';
import 'package:solgis/core/theme/theme.dart';

class LoginGeneralForm extends StatelessWidget {
  
  const LoginGeneralForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    //VARIABLES
    final homeProvider = Provider.of<HomeProvider>(context);
    final size = MediaQuery.of(context).size;
    final resizeNotifier = ValueNotifier<bool>(false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      if (!resizeNotifier.value) resizeNotifier.value = true;
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 3) {
            resizeNotifier.value = false;
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder<bool>(
              valueListenable: resizeNotifier,
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  bottom: value ? 0 : -size.height * .5,
                  left: 0,
                  right: 0,
                  child: child!,
                );
              },

              child: SizedBox(
                height: size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * .1),
                    Center(
                      child: Image(
                        width: size.width*0.5,
                        height: size.height*0.1,
                        image: const AssetImage('assets/pngs/SOLMAR.png'),
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: _DragDownIndication(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 55),
                          child: ClipPath(
                            clipper: InvertedTopBorderClipper(
                              circularRadius: 40,
                            ),
                            child: Container(
                              height: 340,
                              width: double.infinity,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal:40),

                              child: SingleChildScrollView(
                                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[

                                    const SizedBox(height: 60),
                                    TextInputLoginGeneral(
                                      controller: homeProvider.userController, 
                                      label: 'Nombre de usuario',
                                      iconData: Icons.person,
                                      textInputType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 30),
                                    TextInputLoginGeneral(
                                      controller: homeProvider.passController, 
                                      label: 'Contraseña',
                                      iconData: Icons.lock_outline,
                                      textInputType:TextInputType.visiblePassword,
                                    ),
                                    const SizedBox(height: 30),
                                    SizedBox(
                                      width: size.width * .85,
                                      child: TextButton(
                                        onPressed: (homeProvider.isLoading)
                                          ? null
                                          : () async {

                                              await signInWithCredentials(context, homeProvider.userController.text.trim(), homeProvider.passController.text.trim());

                                          },

                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white, padding: const EdgeInsets.all(12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor: AppThemeGeneral.lighTheme.primaryColor,
                                        ),
                                        child: (homeProvider.isLoading)
                                          ? const CircularProgressIndicator()
                                          : const Text(
                                            'Iniciar Sesion',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                          ),
                                      ),
                                    )

                                  ],
                                ),

                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DragDownIndication extends StatelessWidget {
  const _DragDownIndication();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Inicia sesión',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white
          ),
        ),
        Text(
          'Desliza para ir hacia atras',
          style: TextStyle(
            height: 2,
            fontSize: 14,
            color: Colors.white.withOpacity(.9),

          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white.withOpacity(.8),
          size: 35,
        ),
      ],
    );
  }
}
