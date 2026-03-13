import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/custom_button.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/services/auth_service.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/features/auth/view_model/auth_state.dart'; 
import 'package:growiq/core/functions/navigation.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final AuthCubit _authCubit;
  
  late TextEditingController _nameController;
  
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    final currentUser = getIt<AuthService>().currentUser;
    _nameController = TextEditingController(text: currentUser?.displayName ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    await _authCubit.updateProfile(
      newName: _nameController.text,
      newImage: _selectedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final photoURL = getIt<AuthService>().currentUser?.photoURL;
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.profile),
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: _authCubit,
        listener: (context, state) {
          if (state is ProfileUpdateSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.profileUpdatedSuccess)),
            );
            customPop(context, result: true);
          } else if (state is ProfileUpdateFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${AppStrings.errorPrefix}${state.errMessage}')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!) as ImageProvider
                            : (photoURL != null
                                ? CachedNetworkImageProvider(photoURL)
                                : const AssetImage(Assets.imagesLogoApp) as ImageProvider),
                      ),
                      InkWell(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.lightMint,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: AppColors.primaryColor),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none, 
                                hintText: AppStrings.name,
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Icon(Icons.edit, size: 18, color: AppColors.greyColor), 
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  state is ProfileUpdateLoadingState
                      ? const CircularProgressIndicator()
                      : CustomButtom(
                          text: AppStrings.save,
                          onPressed: _saveProfile,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}