import 'package:flutter/material.dart';
import 'package:shop_app2/Helper/HelperMethods.dart';

class VertificationScreen extends StatelessWidget {
  var FormKey = GlobalKey<FormState>();
  TextEditingController verification1 = new TextEditingController();
  TextEditingController verification2 = new TextEditingController();
  TextEditingController verification3 = new TextEditingController();
  TextEditingController verification4 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String number =ModalRoute.of(context).settings.name ;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'OTP Verification',
            style: TextStyle(fontSize: 20.0, color: Colors.black54),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: FormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Text(
                  'OTP Verification',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'We sent your code to ${number}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    /*  TextFormField(
                        controller: verification1,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      )*/
                      /*  defaultTextForm(controller: verification1, type: TextInputType.name, validate_message: 'Enter your verification number'),
                   */ /*   defaultTextForm(controller: verification2, type: TextInputType.name, validate_message: 'Enter your verification number'),
                      defaultTextForm(controller: verification3, type: TextInputType.name, validate_message: 'Enter your verification number'),
                      defaultTextForm(controller: verification4, type: TextInputType.name, validate_message: 'Enter your verification number')*/
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildBtn(() {
                  if (FormKey.currentState.validate()) {
                    NavigateTo(context, VertificationScreen());
                  }
                }, 'Next'),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
