import 'dart:io';
import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> resumeOne({
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
  final resume1 = Document();

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

  final emailIconBlack = MemoryImage(
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

  resume1.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 0,
        marginRight: 0,
        marginTop: 0,
        marginBottom: 0,
      ),
      build: (context) {
        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 120,
                  width: 20,
                  decoration:
                      BoxDecoration(color: PdfColor.fromHex("#283546"))),
              Container(
                  height: double.infinity,
                  width: 192,
                  decoration: BoxDecoration(color: PdfColor.fromHex("#eaeaea")),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 32),
                        Center(
                            child: Container(
                                height: 112,
                                width: 112,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: image, fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: PdfColor.fromHex("#283546"),
                                        width: 1.2)))),
                        SizedBox(height: 28),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("CONTACT",
                                      style: TextStyle(
                                          color: PdfColor.fromHex("#283546"),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                          fontSize: 14)),
                                  SizedBox(height: 4),
                                  Container(
                                      height: 1,
                                      width: 82,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                                  SizedBox(height: 24),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image(
                                          height: 12,
                                          width: 12,
                                          phoneCallIconBlack,
                                        ),
                                        SizedBox(width: 12),
                                        Container(
                                            width: 120,
                                            // color: PdfColors.amberAccent100,
                                            child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}",
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF777777),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal))),
                                      ]),
                                  SizedBox(height: 4),
                                  Container(
                                      height: 1,
                                      width: 152,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                                  SizedBox(height: 12),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image(
                                          height: 12,
                                          width: 12,
                                          emailIconBlack,
                                        ),
                                        SizedBox(width: 12),
                                        Container(
                                            width: 120,
                                            // color: PdfColors.amberAccent100,
                                            child: Text(emailAddress.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF777777),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal))),
                                      ]),
                                  SizedBox(height: 4),
                                  Container(
                                      height: 1,
                                      width: 152,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                                  SizedBox(height: 12),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image(
                                          height: 12,
                                          width: 12,
                                          pinIconBlack,
                                        ),
                                        SizedBox(width: 12),
                                        Container(
                                            width: 120,
                                            // color: PdfColors.amberAccent100,
                                            child: Text(address.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                    color:
                                                        const PdfColor.fromInt(
                                                            0xFF777777),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal))),
                                      ]),
                                  SizedBox(height: 4),
                                  Container(
                                      height: 1,
                                      width: 152,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                                  education!.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 40),
                                  education.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("EDUCATION",
                                          style: TextStyle(
                                              color:
                                                  PdfColor.fromHex("#283546"),
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2,
                                              fontSize: 14)),
                                  education.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 4),
                                  education.isEmpty
                                      ? SizedBox(height: 0)
                                      : Container(
                                          height: 1,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color:
                                                  PdfColor.fromHex("#c2c2c2"))),
                                  education.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 24),
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
                                                padding: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 152,
                                                        child: Text(
                                                            educations.degree
                                                                .toString()
                                                                .toUpperCase(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                                color: PdfColor
                                                                    .fromHex(
                                                                        "#283546"),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Container(
                                                          // color: PdfColors
                                                          //     .amber100,
                                                          width: 152,
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
                                                                      0xFF777777),
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal))),
                                                      SizedBox(height: 2),
                                                      Container(
                                                          // color: PdfColors
                                                          //     .amber100,
                                                          width: 152,
                                                          child: Text(
                                                              "${educations.start.toString()} - ${educations.end.toString()}",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  color: const PdfColor
                                                                      .fromInt(
                                                                      0xFF777777),
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)))
                                                    ]));
                                          },
                                        ),
                                  skill!.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 20),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : Text("SKILLS",
                                          style: TextStyle(
                                              color:
                                                  PdfColor.fromHex("#283546"),
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2,
                                              fontSize: 14)),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 4),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : Container(
                                          height: 1,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color:
                                                  PdfColor.fromHex("#c2c2c2"))),
                                  skill.isEmpty
                                      ? SizedBox(height: 0)
                                      : SizedBox(height: 24),
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
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          width: 80,
                                                          // color: PdfColors
                                                          //     .amber900,
                                                          child: Text(
                                                              skills.skillName
                                                                  .toString(),
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  color: PdfColor
                                                                      .fromHex(
                                                                          "#283546"),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal))),
                                                      SizedBox(width: 16),
                                                      Container(
                                                          width: 70,
                                                          height: 2.5,
                                                          child: LinearProgressIndicator(
                                                              value: skills
                                                                  .expertise,
                                                              backgroundColor:
                                                                  PdfColor.fromHex(
                                                                      "#c2c2c2"),
                                                              valueColor: PdfColor
                                                                  .fromHex(
                                                                      "#283546"),
                                                              minHeight: 5))
                                                    ]));
                                          })
                                ]))
                      ])),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 120,
                        width: 384,
                        decoration:
                            BoxDecoration(color: PdfColor.fromHex("#283546")),
                        child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 32),
                                  Container(
                                      width: 340,
                                      // color: PdfColors.amberAccent,
                                      child: Text(
                                          "${firstName.toString().toUpperCase()} ${lastName.toString().toUpperCase()}",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: PdfColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32))),
                                  SizedBox(height: 6),
                                  Container(
                                      width: 340,
                                      child: Text(
                                          capitalizeFirstLetterOfEachWord(
                                              designation.toString()),
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: PdfColors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)))
                                ]))),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 48),
                              Text("PROFILE",
                                  style: TextStyle(
                                      color: PdfColor.fromHex("#283546"),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontSize: 14)),
                              SizedBox(height: 4),
                              Container(
                                  height: 1,
                                  width: 72,
                                  decoration: BoxDecoration(
                                      color: PdfColor.fromHex("#c2c2c2"))),
                              SizedBox(height: 20),
                              Container(
                                  width: 332,
                                  // color: PdfColors.amberAccent700,
                                  child: Text(profile.toString(),
                                      maxLines: 5,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: const PdfColor.fromInt(
                                              0xFF777777),
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal))),
                              experience!.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 40),
                              experience.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("WORK EXPERIENCE",
                                      style: TextStyle(
                                          color: PdfColor.fromHex("#283546"),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                          fontSize: 14)),
                              experience.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 4),
                              experience.isEmpty
                                  ? SizedBox(height: 0)
                                  : Container(
                                      height: 1,
                                      width: 166,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
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
                                                bottom: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 332,
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 160,
                                                            // color: PdfColors
                                                            //     .amberAccent700,
                                                            child: Text(
                                                                experiences
                                                                    .jobTitle
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    color: PdfColor
                                                                        .fromHex(
                                                                            "#283546"),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10)),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            width: 140,
                                                            // color:
                                                            //     PdfColors.green,
                                                            child: Text(
                                                                "${experiences.start} - ${experiences.end}",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    color: const PdfColor
                                                                        .fromInt(
                                                                        0xFF777777),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        10)),
                                                          ),
                                                        ]),
                                                  ),
                                                  Container(
                                                      width: 332,
                                                      child: Text(
                                                          "${experiences.employer.toString()}, ${capitalizeFirstLetterOfEachWord(experiences.city.toString())}",
                                                          overflow:
                                                              TextOverflow.clip,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF777777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 10))),
                                                  // Container(
                                                  //   width: 332,
                                                  //   child: Text(
                                                  //       "${experiences.start} - ${experiences.end}",
                                                  //       maxLines: 1,
                                                  //       overflow:
                                                  //           TextOverflow.clip,
                                                  //       style: TextStyle(
                                                  //           color:
                                                  //               const PdfColor
                                                  //                   .fromInt(
                                                  //                   0xFF777777),
                                                  //           fontWeight:
                                                  //               FontWeight
                                                  //                   .normal,
                                                  //           fontSize: 10)),
                                                  // ),
                                                  SizedBox(height: 4),
                                                  Container(
                                                    width: 332,
                                                    child: Text(
                                                        experiences.description
                                                            .toString(),
                                                        maxLines: 3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF777777),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 10)),
                                                  ),
                                                ]));
                                      },
                                    ),
                              project!.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 30),
                              project.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("EXPERIENCE",
                                      style: TextStyle(
                                          color: PdfColor.fromHex("#283546"),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                          fontSize: 14)),
                              project.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 4),
                              project.isEmpty
                                  ? SizedBox(height: 0)
                                  : Container(
                                      height: 1,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 332,
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 200,
                                                              child: Text(
                                                                  projects
                                                                      .projectName
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style: TextStyle(
                                                                      color: PdfColor
                                                                          .fromHex(
                                                                              "#283546"),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          10)),
                                                            ),
                                                            Container(
                                                                width: 100,
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    projects
                                                                        .projectDate,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines: 2,
                                                                    style: TextStyle(
                                                                        color: const PdfColor
                                                                            .fromInt(
                                                                            0xFF777777),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            10))),
                                                          ])),
                                                  SizedBox(height: 4),
                                                  Container(
                                                    width: 332,
                                                    child: Text(
                                                        projects
                                                            .projectDescription
                                                            .toString(),
                                                        maxLines: 3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF777777),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 10)),
                                                  ),
                                                ]));
                                      },
                                    ),
                              certificate!.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 30),
                              certificate.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("CERTIFICATES",
                                      style: TextStyle(
                                          color: PdfColor.fromHex("#283546"),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                          fontSize: 14)),
                              certificate.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 4),
                              certificate.isEmpty
                                  ? SizedBox(height: 0)
                                  : Container(
                                      height: 1,
                                      width: 124,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                              certificate.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 20),
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 332,
                                                    child: Text(
                                                        certificates.issuedFor
                                                            .toString()
                                                            .toUpperCase(),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            color: PdfColor
                                                                .fromHex(
                                                                    "#283546"),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10)),
                                                  ),
                                                  Container(
                                                      width: 332,
                                                      child: Text(
                                                          certificates
                                                              .issuingBody,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF777777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 10))),
                                                  SizedBox(height: 4),
                                                  Container(
                                                    width: 332,
                                                    child: Text(
                                                        certificates.issuedOn
                                                            .toString(),
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF777777),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 10)),
                                                  ),
                                                ]));
                                      },
                                    ),
                            ]))
                  ])
            ]);
      },
    ),
  );
  return resume1.save();
}
