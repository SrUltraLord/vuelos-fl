import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final Function onPressed;

  const FormButton(
      {Key? key,
      required this.text,
      required this.isLoading,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isLoading ? null : () => onPressed(),
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.blueAccent,
      disabledColor: Colors.grey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: isLoading
            ? const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
