import 'dart:io';
import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> resumeSeven({
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
  final resume7 = Document();

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

  final emailIconWhite = MemoryImage(
      (await rootBundle.load('assets/icons/emailWhite.png'))
          .buffer
          .asUint8List());
  final phoneCallIconWhite = MemoryImage(
      (await rootBundle.load('assets/icons/phoneCallWhite.png'))
          .buffer
          .asUint8List());
  final pinIconWhite = MemoryImage(
      (await rootBundle.load('assets/icons/pinWhite.png'))
          .buffer
          .asUint8List());

  resume7.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 0,
        marginRight: 0,
        marginTop: 0,
        marginBottom: 0,
      ),
      build: (context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Container(height: 54, width: 1, color: PdfColors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 42),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 320,
                                // color: PdfColors.amberAccent700,
                                child: Text(lastName.toString().toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: PdfColors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                        letterSpacing: 4))),
                            Container(
                                width: 320,
                                // color: PdfColors.amberAccent700,
                                child: Text(firstName.toString().toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: PdfColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 38,
                                        letterSpacing: 4))),
                            Container(
                                width: 320,
                                // color: PdfColors.amberAccent700,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: ((10 -
                                                firstName!.length.toDouble()) *
                                            40)),
                                    child: Text(
                                        designation.toString().toUpperCase(),
                                        maxLines: 1,
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: const PdfColor.fromInt(
                                                0xFF444343),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            letterSpacing: 4)))),
                          ]),
                      Padding(
                          padding: const EdgeInsets.only(
                            right: 46,
                          ),
                          child: Container(
                              height: 92,
                              width: 92,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: image, fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              ))),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Container(height: 48, width: 1, color: PdfColors.black),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 172,
                            // color: PdfColors.amberAccent700,
                            height: 600,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 6),
                                  Text("CONTACT",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          letterSpacing: 4)),
                                  SizedBox(height: 6),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Container(
                                        height: 14,
                                        width: 1,
                                        color: PdfColors.black),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 18,
                                            width: 18,
                                            decoration: const BoxDecoration(
                                                color: PdfColors.black,
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child: Image(
                                                    height: 10,
                                                    width: 10,
                                                    pinIconWhite))),
                                        SizedBox(width: 8),
                                        Container(
                                            width: 140,
                                            // color:
                                            //     PdfColors.lightGreenAccent700,
                                            child: Text(address.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF444343),
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal)))
                                      ]),
                                  SizedBox(height: 6),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 18,
                                            width: 18,
                                            decoration: const BoxDecoration(
                                                color: PdfColors.black,
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child: Image(
                                                    height: 10,
                                                    width: 10,
                                                    phoneCallIconWhite))),
                                        SizedBox(width: 8),
                                        Container(
                                            width: 140,
                                            // color:
                                            //     PdfColors.lightGreenAccent700,
                                            child: Text(
                                                "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}",
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF444343),
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal)))
                                      ]),
                                  SizedBox(height: 6),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 18,
                                            width: 18,
                                            decoration: const BoxDecoration(
                                                color: PdfColors.black,
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child: Image(
                                                    height: 10,
                                                    width: 10,
                                                    emailIconWhite))),
                                        SizedBox(width: 8),
                                        Container(
                                            width: 140,
                                            // color:
                                            //     PdfColors.lightGreenAccent700,
                                            child: Text(emailAddress.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF444343),
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal)))
                                      ]),
                                  skill!.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 26),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("SKILLS",
                                          style: TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              letterSpacing: 4)),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 16),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : ListView.builder(
                                          itemCount: skill.length,
                                          itemBuilder: (context, int index) {
                                            final skills = skill[index];
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          height: 4,
                                                          width: 4,
                                                          decoration: BoxDecoration(
                                                              color: PdfColors
                                                                  .white,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color:
                                                                      PdfColors
                                                                          .black,
                                                                  width: 1.4))),
                                                      SizedBox(width: 12),
                                                      Container(
                                                          width: 140,
                                                          child: Text(
                                                              skills.skillName
                                                                  .toString(),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  color: const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)))
                                                    ]));
                                          },
                                        ),
                                  education!.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 26),
                                  education.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("EDUCATION",
                                          style: TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              letterSpacing: 4)),
                                  education.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 16),
                                  education.isEmpty
                                      ? SizedBox(height: 0)
                                      : ListView.builder(
                                          reverse: true,
                                          itemCount: education.length,
                                          itemBuilder: (context, int index) {
                                            final educations = education[index];
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 16,
                                                ),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          height: 4,
                                                          width: 4,
                                                          decoration: BoxDecoration(
                                                              color: PdfColors
                                                                  .white,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color:
                                                                      PdfColors
                                                                          .black,
                                                                  width: 1.4))),
                                                      SizedBox(width: 12),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                width: 140,
                                                                // color: PdfColors
                                                                //     .lightGreenAccent700,
                                                                child: Text(
                                                                    educations
                                                                        .degree
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: TextStyle(
                                                                        color: PdfColors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            10))),
                                                            SizedBox(height: 4),
                                                            Container(
                                                                width: 140,
                                                                child: Text(
                                                                    educations
                                                                        .schoolOrCollege
                                                                        .toString(),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: TextStyle(
                                                                        color: const PdfColor
                                                                            .fromInt(
                                                                            0xFF444343),
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.normal))),
                                                            Container(
                                                                width: 140,
                                                                child: Text(
                                                                    "${educations.start.toString()} - ${educations.end.toString()}",
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: TextStyle(
                                                                        color: const PdfColor
                                                                            .fromInt(
                                                                            0xFF444343),
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.normal)))
                                                          ])
                                                    ]));
                                          },
                                        ),
                                ])),
                        SizedBox(width: 16),
                        Container(
                            width: 332,
                            // color: PdfColors.lightGreenAccent700,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 6),
                                  Text("PROFILE",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          letterSpacing: 4)),
                                  SizedBox(height: 26),
                                  Container(
                                      width: 332,
                                      child: Text(profile.toString(),
                                          maxLines: 5,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: const PdfColor.fromInt(
                                                  0xFF444343),
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal))),
                                  experience!.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 20),
                                  experience.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("WORK EXPERIENCE",
                                          style: TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              letterSpacing: 4)),
                                  experience.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 20),
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
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          height: 4,
                                                          width: 4,
                                                          decoration: BoxDecoration(
                                                              color: PdfColors
                                                                  .white,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color:
                                                                      PdfColors
                                                                          .black,
                                                                  width: 1.4))),
                                                      SizedBox(width: 12),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: RichText(
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                "${experiences.jobTitle.toString().toUpperCase()}  |  ",
                                                                            style: TextStyle(
                                                                                color: PdfColors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 10)),
                                                                        TextSpan(
                                                                            text:
                                                                                "${experiences.start.toString()} - ${experiences.end.toString()}",
                                                                            style: TextStyle(
                                                                                color: const PdfColor.fromInt(0xFF444343),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.normal))
                                                                      ])),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Container(
                                                              width: 300,
                                                              child: Text(
                                                                  "${experiences.employer.toString().toUpperCase()}, ${experiences.city.toString().toUpperCase()}",
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style: TextStyle(
                                                                      color: const PdfColor
                                                                          .fromInt(
                                                                          0xFF444343),
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Container(
                                                                width: 300,
                                                                child: Text(
                                                                    experiences
                                                                        .description
                                                                        .toString(),
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: TextStyle(
                                                                        color: const PdfColor
                                                                            .fromInt(
                                                                            0xFF444343),
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.normal)))
                                                          ])
                                                    ]));
                                          },
                                        ),
                                  project!.isEmpty
                                      ? SizedBox(height: 0)
                                      : experience.isEmpty
                                          ? SizedBox(height: 20)
                                          : SizedBox(height: 0),
                                  project.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("EXPERIENCE",
                                          style: TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              letterSpacing: 4)),
                                  project.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 20),
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
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          height: 4,
                                                          width: 4,
                                                          decoration: BoxDecoration(
                                                              color: PdfColors
                                                                  .white,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color:
                                                                      PdfColors
                                                                          .black,
                                                                  width: 1.4))),
                                                      SizedBox(width: 12),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: RichText(
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                "${projects.projectName.toString().toUpperCase()}  |  ",
                                                                            style: TextStyle(
                                                                                color: PdfColors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 10)),
                                                                        TextSpan(
                                                                            text: projects.projectDate
                                                                                .toString(),
                                                                            style: TextStyle(
                                                                                color: const PdfColor.fromInt(0xFF444343),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.normal))
                                                                      ])),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Container(
                                                                width: 300,
                                                                child: Text(
                                                                    projects
                                                                        .projectDescription
                                                                        .toString(),
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: TextStyle(
                                                                        color: const PdfColor
                                                                            .fromInt(
                                                                            0xFF444343),
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.normal)))
                                                          ])
                                                    ]));
                                          },
                                        ),
                                  certificate!.isEmpty
                                      ? SizedBox(height: 0)
                                      : project.isEmpty || experience.isEmpty
                                          ? SizedBox(height: 20)
                                          : SizedBox(height: 0),
                                  certificate.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("CERTIFICATES",
                                          style: TextStyle(
                                              color: PdfColors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                              letterSpacing: 4)),
                                  certificate.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 20),
                                  certificate.isEmpty
                                      ? SizedBox(height: 0)
                                      : ListView.builder(
                                          reverse: true,
                                          itemCount: certificate.length,
                                          itemBuilder: (context, int index) {
                                            final certificates =
                                                certificate[index];
                                            return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          height: 4,
                                                          width: 4,
                                                          decoration: BoxDecoration(
                                                              color: PdfColors
                                                                  .white,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color:
                                                                      PdfColors
                                                                          .black,
                                                                  width: 1.4))),
                                                      SizedBox(width: 12),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: 300,
                                                              child: RichText(
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                            text:
                                                                                "${certificates.issuedFor.toString().toUpperCase()}  |  ",
                                                                            style: TextStyle(
                                                                                color: PdfColors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 10)),
                                                                        TextSpan(
                                                                            text: certificates.issuedOn
                                                                                .toString(),
                                                                            style: TextStyle(
                                                                                color: const PdfColor.fromInt(0xFF444343),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.normal))
                                                                      ])),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Container(
                                                                width: 300,
                                                                child: Text(
                                                                    certificates
                                                                        .issuingBody
                                                                        .toString(),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: TextStyle(
                                                                        color: const PdfColor
                                                                            .fromInt(
                                                                            0xFF444343),
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.normal)))
                                                          ])
                                                    ]));
                                          },
                                        ),
                                ])),
                      ]))
            ]);
      },
    ),
  );
  return resume7.save();
}
