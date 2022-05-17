import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/component.dart';

class UpDateScreen extends StatelessWidget {
  UpDateScreen({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userData;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData != null,
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    const Text(
                      'Update your profile information',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter your name';
                        }
                        return null;
                      },
                      label: 'User Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter your email';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter your phone number';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone_android_outlined,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultButton(
                      function: () {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      },
                      text: 'Update Profile',
                      radius: 40.0,
                      background: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => circularP(),
        );
      },
    );
  }
}
