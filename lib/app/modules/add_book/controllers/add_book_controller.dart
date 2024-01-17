import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart 'as dio;
import 'package:petugas_perpustakaan_app1/app/data/constant/endpoint.dart';
import 'package:petugas_perpustakaan_app1/app/data/provider/api_provider.dart';

class AddBookController extends GetxController {
  //TODO: Implement AddBookController
  final GlobalKey<FormState> formKey= GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void increment() => count.value++;

  final loadingBook = false.obs;
  addBook() async {
    loadingBook(true);
    try{
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save() ;
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data:
              {
                "judul": judulController,
                "penulis": penulisController,
                "penerbit": penerbitController,
                "tahun_terbit": int.parse(tahunController.text.toString())
              }
            );
        if (response.statusCode == 201) {
           Get.back();
        }else {
          Get.snackbar("Sorry","Gagal menyimpan data", backgroundColor: Colors.orange);
        }
      }
      loadingBook(false);
    } on dio.DioException catch (e) {
      loadingBook(false);
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    }catch (e) {
      loadingBook(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      throw Exception('Error: $e');
    }
  }
}
