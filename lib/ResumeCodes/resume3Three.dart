import 'dart:io';
import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> resumeThree({
  bool? hasSaved,
  bool? isServerData,
  bool? isBlackNWhite,
  String? firstName,
  String? lastName,
  String? designation,
  String? address,
  String? emailAddress,
  String? phoneNo,
  String? imagePath,
  List? skill,
  List? education,
  List? experience,
  List? project,
  List? certificate,
  String? profile,
  String? countryCode,
}) async {
  final resume3 = Document();
  final image = hasSaved!
      ? await networkImage(imagePath.toString())
      : isServerData!
          ? isBlackNWhite!
              ? MemoryImage(
                  File(imagePath.toString()).readAsBytesSync(),
                )
              : await networkImage(imagePath.toString())
          : MemoryImage(
              File(imagePath.toString()).readAsBytesSync(),
            );

  final mailIconBlack = MemoryImage(
      (await rootBundle.load('assets/icons/emailBlack.png'))
          .buffer
          .asUint8List());
  final phoneCallIconBlack = MemoryImage(
      (await rootBundle.load('assets/icons/phoneCallBlack.png'))
          .buffer
          .asUint8List());
  final pinIconBlack = MemoryImage(
      (await rootBundle.load('assets/icons/pinBlack.png'))
          .buffer
          .asUint8List());

  resume3.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 36,
        marginRight: 36,
        marginTop: 36,
        marginBottom: 36,
      ),
      build: (context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(height: 284, width: 115, image, fit: BoxFit.cover),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 80),
                                Container(
                                    height: 50,
                                    width: 1,
                                    color: PdfColors.black),
                                SizedBox(width: 20),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              phoneCallIconBlack,
                                              height: 10,
                                              width: 10,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                                "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}",
                                                style: const TextStyle(
                                                    color: PdfColor.fromInt(
                                                        0xFF777777)))
                                          ]),
                                      SizedBox(height: 8),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              mailIconBlack,
                                              height: 10,
                                              width: 10,
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                                width: 100,
                                                child: Text(
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    emailAddress.toString(),
                                                    style: const TextStyle(
                                                        color: PdfColor.fromInt(
                                                            0xFF777777))))
                                          ])
                                    ]),
                                SizedBox(width: 40),
                                Container(
                                    height: 50,
                                    width: 1,
                                    color: PdfColors.black),
                                SizedBox(width: 20),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        pinIconBlack,
                                        height: 10,
                                        width: 10,
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                          width: 100,
                                          child: Text(address.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.clip,
                                              style: const TextStyle(
                                                  color: PdfColor.fromInt(
                                                      0xFF777777))))
                                    ])
                              ]),
                          SizedBox(height: 20),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 140,
                                        // color: PdfColors.red100,
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            firstName.toString().length <
                                                    lastName.toString().length
                                                ? firstName
                                                    .toString()
                                                    .toUpperCase()
                                                : lastName
                                                    .toString()
                                                    .toUpperCase(),
                                            style: TextStyle(
                                                letterSpacing: 1.2,
                                                color: PdfColors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18)),
                                      ),
                                      Container(
                                          width: 300,
                                          // color: PdfColors.red100,
                                          child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              firstName.toString().length >
                                                      lastName.toString().length
                                                  ? firstName
                                                      .toString()
                                                      .toUpperCase()
                                                  : lastName
                                                      .toString()
                                                      .toUpperCase(),
                                              style: TextStyle(
                                                  letterSpacing: 2,
                                                  color: PdfColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40))),
                                      SizedBox(height: 8),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 60),
                                            Container(
                                                height: 16,
                                                width: 1,
                                                color: PdfColors.black),
                                            SizedBox(width: 20),
                                            Container(
                                                width: 220,
                                                // color: PdfColors.red100,
                                                child: Text(
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    designation
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        letterSpacing: 2,
                                                        color: PdfColor.fromInt(
                                                            0xFF777777))))
                                          ]),
                                      SizedBox(height: 18),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 60),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "PROFILE",
                                                    style: TextStyle(
                                                        letterSpacing: 2,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: PdfColors.black,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(height: 12),
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            width: 1,
                                                            height: 76,
                                                            color: PdfColors
                                                                .black),
                                                        SizedBox(width: 20),
                                                        Container(
                                                            width: 300,
                                                            // color: PdfColors
                                                            //     .red100,
                                                            child: Text(
                                                                maxLines: 5,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                profile
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: PdfColor
                                                                        .fromInt(
                                                                            0xFF777777))))
                                                      ])
                                                ])
                                          ])
                                    ])
                              ])
                        ])
                  ]),
              SizedBox(height: 30),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          skill!.isEmpty
                              ? SizedBox(height: 0)
                              : Text(
                                  "SKILLS",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black,
                                      fontSize: 14),
                                ),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 20),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  itemCount: skill
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final skills = skill[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: Container(
                                            width: 140,
                                            // color: PdfColors.red100,
                                            child: RichText(
                                                maxLines: 2,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "-   ",
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text: skills.skillName
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: PdfColor.fromInt(
                                                            0xFF777777),
                                                      ))
                                                ]))));
                                  },
                                ),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 30),
                          education!.isEmpty
                              ? SizedBox(height: 0)
                              : Text(
                                  "EDUCATION",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black,
                                      fontSize: 14),
                                ),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 20),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: education
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final educations = education[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Container(
                                            width: 140,
                                            // color: PdfColors.red100,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      educations.degree
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(height: 4),
                                                  Text(
                                                      "${educations.schoolOrCollege.toString()}, ${capitalizeFirstLetterOfEachWord(educations.city.toString())}",
                                                      style: const TextStyle(
                                                        color: PdfColor.fromInt(
                                                            0xFF777777),
                                                        fontSize: 12,
                                                      )),
                                                  SizedBox(height: 4),
                                                  Text(
                                                      "${educations.start} - ${educations.end}",
                                                      style: const TextStyle(
                                                        color: PdfColor.fromInt(
                                                            0xFF777777),
                                                        fontSize: 12,
                                                      )),
                                                ])));
                                  },
                                ),
                        ]),
                    SizedBox(width: 54),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          experience!.isEmpty
                              ? SizedBox(height: 0)
                              : Text(
                                  "WORK EXPERIENCE",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black,
                                      fontSize: 14),
                                ),
                          experience.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 12),
                          experience.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: experience
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final experiences = experience[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                            width: 316,
                                            // color: PdfColors.red100,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 180,
                                                          // color:
                                                          // PdfColors.red300,
                                                          child: Text(
                                                              maxLines: 2,
                                                              experiences
                                                                  .jobTitle
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  color:
                                                                      PdfColors
                                                                          .black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          width: 136,
                                                          // color:
                                                          //     PdfColors.red300,
                                                          child: Text(
                                                              maxLines: 1,
                                                              "${experiences.start} - ${experiences.end}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: const PdfColor
                                                                    .fromInt(
                                                                    0xFF777777),
                                                                fontSize: 12,
                                                              )),
                                                        )
                                                      ]),
                                                  Text(
                                                      "${experiences.employer.toString()}, ${capitalizeFirstLetterOfEachWord(experiences.city.toString())}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontSize: 12,
                                                      )),
                                                  SizedBox(height: 4),
                                                  Text(
                                                      maxLines: 3,
                                                      experiences.description
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontSize: 12,
                                                      )),
                                                ])));
                                  },
                                ),
                          project!.isEmpty
                              ? SizedBox(height: 0)
                              : experience.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 20),
                          project.isEmpty
                              ? SizedBox(height: 0)
                              : Text(
                                  "EXPERIENCE",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black,
                                      fontSize: 14),
                                ),
                          project.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 12),
                          project.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: project
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final projects = project[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                            width: 316,
                                            // color: PdfColors.red100,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          // color:
                                                          //     PdfColors.red300,
                                                          child: Text(
                                                              maxLines: 2,
                                                              projects
                                                                  .projectName
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  color:
                                                                      PdfColors
                                                                          .black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          width: 92,
                                                          // color:
                                                          //     PdfColors.red300,
                                                          child: Text(
                                                              maxLines: 1,
                                                              "${projects.projectDate}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: const PdfColor
                                                                    .fromInt(
                                                                    0xFF777777),
                                                                fontSize: 12,
                                                              )),
                                                        )
                                                      ]),
                                                  SizedBox(height: 4),
                                                  Text(
                                                      maxLines: 3,
                                                      "${projects.projectDescription}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontSize: 12,
                                                      )),
                                                ])));
                                  },
                                ),
                          certificate!.isEmpty
                              ? SizedBox(height: 0)
                              : experience.isEmpty || project.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 20),
                          certificate.isEmpty
                              ? SizedBox(height: 0)
                              : Text(
                                  "CERTIFICATES",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.black,
                                      fontSize: 14),
                                ),
                          certificate.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 12),
                          certificate.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: certificate
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final certificates = certificate[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                            width: 316,
                                            // color: PdfColors.red100,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          // color:
                                                          //     PdfColors.red300,
                                                          child: Text(
                                                              maxLines: 2,
                                                              certificates
                                                                  .issuedFor
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  color:
                                                                      PdfColors
                                                                          .black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          width: 92,
                                                          // color:
                                                          //     PdfColors.red300,
                                                          child: Text(
                                                              maxLines: 1,
                                                              "${certificates.issuedOn}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: const PdfColor
                                                                    .fromInt(
                                                                    0xFF777777),
                                                                fontSize: 12,
                                                              )),
                                                        )
                                                      ]),
                                                  SizedBox(height: 4),
                                                  Text(
                                                      maxLines: 1,
                                                      "${certificates.issuingBody}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontSize: 12,
                                                      )),
                                                ])));
                                  },
                                ),
                        ])
                  ]),
            ]);
      },
    ),
  );
  return resume3.save();
}
