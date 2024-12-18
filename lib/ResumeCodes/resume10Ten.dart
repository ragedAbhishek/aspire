import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> resumeTen({
  bool? hasSaved,
  String? firstName,
  String? lastName,
  String? designation,
  String? address,
  String? emailAddress,
  String? phoneNo,
  List? skill,
  List? education,
  List? experience,
  List? project,
  List? certificate,
  String? profile,
  String? countryCode,
}) async {
  final resume10 = Document();

  final nameFont = await PdfGoogleFonts.poppinsMedium();
  final designationFont = await PdfGoogleFonts.poppinsRegular();
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

  resume10.addPage(
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
                  width: 40,
                  height: double.infinity,
                  color: PdfColor.fromHex("#F3F4F5")),
              SizedBox(width: 24),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),
                    Container(
                        width: 500,
                        // color: PdfColors.amberAccent700,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 280,
                                        // color: PdfColors.amberAccent700,
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            "${firstName.toString().toUpperCase()}  ${lastName.toString().toUpperCase()}",
                                            style: TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 28,
                                                font: nameFont))),
                                    Container(
                                        width: 280,
                                        // color: PdfColors.amberAccent700,
                                        child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            designation
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: const PdfColor.fromInt(
                                                    0xFF444343),
                                                fontSize: 15,
                                                font: designationFont)))
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image(pinIconBlack,
                                              height: 10,
                                              width: 10,
                                              fit: BoxFit.cover),
                                          SizedBox(width: 6),
                                          Container(
                                              width: 120,
                                              // color: PdfColors.amberAccent700,
                                              child: Text(
                                                  capitalizeFirstLetterOfEachWord(
                                                      address.toString()),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      color: const PdfColor
                                                          .fromInt(0xFF444343),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10)))
                                        ]),
                                    SizedBox(height: 6),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image(phoneCallIconBlack,
                                              height: 10,
                                              width: 10,
                                              fit: BoxFit.cover),
                                          SizedBox(width: 8),
                                          Container(
                                              width: 120,
                                              // color: PdfColors.amberAccent700,
                                              child: Text(
                                                  "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      color: const PdfColor
                                                          .fromInt(0xFF444343),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10)))
                                        ]),
                                    SizedBox(height: 6),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image(emailIconBlack,
                                              height: 10,
                                              width: 10,
                                              fit: BoxFit.cover),
                                          SizedBox(width: 8),
                                          Container(
                                              width: 120,
                                              // color: PdfColors.amberAccent700,
                                              child: Text(
                                                  emailAddress.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      color: const PdfColor
                                                          .fromInt(0xFF444343),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10)))
                                        ])
                                  ])
                            ])),
                    SizedBox(height: 58),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 2, width: 132, color: PdfColors.black),
                          Container(
                              height: 1,
                              width: 368,
                              color: PdfColor.fromHex("#c2c2c2"))
                        ]),
                    education!.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 10),
                    education.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    width: 132,
                                    child: Text("EDUCATION",
                                        style: TextStyle(
                                            color: PdfColors.black,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            fontSize: 15))),
                                ListView.builder(
                                  reverse: true,
                                  itemCount: education
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final educations = education[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      educations.degree
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13))),
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      "${educations.schoolOrCollege.toString()}, ${educations.start.toString()} - ${educations.end.toString()}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color: const PdfColor
                                                              .fromInt(
                                                              0xFF444343),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12)))
                                            ]));
                                  },
                                ),
                              ]),
                    experience!.isEmpty
                        ? SizedBox(height: 0)
                        : education.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 12),
                    experience.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    height: 2,
                                    width: 132,
                                    color: PdfColors.black),
                                Container(
                                    height: 1,
                                    width: 368,
                                    color: PdfColor.fromHex("#c2c2c2")),
                              ]),
                    experience.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 10),
                    experience.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    width: 132,
                                    child: Text("WORK EXPERIENCE",
                                        style: TextStyle(
                                            color: PdfColors.black,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            fontSize: 15))),
                                ListView.builder(
                                  reverse: true,
                                  itemCount: experience
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final experiences = experience[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      experiences.jobTitle
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13))),
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      "${experiences.employer.toString()}, ${experiences.start.toString()} - ${experiences.end.toString()}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color: const PdfColor
                                                              .fromInt(
                                                              0xFF444343),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12))),
                                              SizedBox(height: 6),
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      experiences.description
                                                          .toString(),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color: const PdfColor
                                                              .fromInt(
                                                              0xFF444343),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12))),
                                            ]));
                                  },
                                ),
                              ]),
                    project!.isEmpty
                        ? SizedBox(height: 0)
                        : education.isEmpty || experience.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 12),
                    project.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    height: 2,
                                    width: 132,
                                    color: PdfColors.black),
                                Container(
                                    height: 1,
                                    width: 368,
                                    color: PdfColor.fromHex("#c2c2c2")),
                              ]),
                    project.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 10),
                    project.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    width: 132,
                                    child: Text("EXPERIENCE",
                                        style: TextStyle(
                                            color: PdfColors.black,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            fontSize: 15))),
                                ListView.builder(
                                  reverse: true,
                                  itemCount: project
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final projects = project[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      projects.projectName
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13))),
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      "${projects.projectDate.toString()}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color: const PdfColor
                                                              .fromInt(
                                                              0xFF444343),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12))),
                                              SizedBox(height: 6),
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      projects
                                                          .projectDescription
                                                          .toString(),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color: const PdfColor
                                                              .fromInt(
                                                              0xFF444343),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12))),
                                            ]));
                                  },
                                ),
                              ]),
                    certificate!.isEmpty
                        ? SizedBox(height: 0)
                        : education.isEmpty ||
                                experience.isEmpty ||
                                project.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 12),
                    certificate.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    height: 2,
                                    width: 132,
                                    color: PdfColors.black),
                                Container(
                                    height: 1,
                                    width: 368,
                                    color: PdfColor.fromHex("#c2c2c2")),
                              ]),
                    certificate.isEmpty
                        ? SizedBox(height: 0)
                        : SizedBox(height: 10),
                    project.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    width: 132,
                                    child: Text("CERTIFICATES",
                                        style: TextStyle(
                                            color: PdfColors.black,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            fontSize: 15))),
                                ListView.builder(
                                  reverse: true,
                                  itemCount: certificate
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final certificates = certificate[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      certificates.issuedFor
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13))),
                                              Container(
                                                  width: 368,
                                                  child: Text(
                                                      "${certificates.issuingBody.toString()}, ${certificates.issuedOn.toString()}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color: const PdfColor
                                                              .fromInt(
                                                              0xFF444343),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 12))),
                                            ]));
                                  },
                                ),
                              ]),
                    skill!.isEmpty
                        ? SizedBox(height: 0)
                        : education.isEmpty ||
                                experience.isEmpty ||
                                project.isEmpty ||
                                certificate.isEmpty
                            ? SizedBox(height: 0)
                            : SizedBox(height: 12),
                    skill.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    height: 2,
                                    width: 132,
                                    color: PdfColors.black),
                                Container(
                                    height: 1,
                                    width: 368,
                                    color: PdfColor.fromHex("#c2c2c2")),
                              ]),
                    skill.isEmpty ? SizedBox(height: 0) : SizedBox(height: 10),
                    skill.isEmpty
                        ? SizedBox(height: 0)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    width: 132,
                                    child: Text("SKILLS",
                                        style: TextStyle(
                                            color: PdfColors.black,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            fontSize: 15))),
                                ListView.builder(
                                  reverse: false,
                                  itemCount: skill
                                      .length, // the number of items in the list
                                  itemBuilder: (context, int index) {
                                    final skills = skill[
                                        index]; // get the skill at the current index
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Container(
                                          width: 140,
                                          // color: PdfColors.amber,
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 70,
                                                  // color: PdfColors.redAccent700,
                                                  child: Text(
                                                      skills.skillName
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                ),
                                                Container(
                                                    width: 52,
                                                    height: 2,
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: skills.expertise,
                                                      valueColor:
                                                          PdfColors.black,
                                                      backgroundColor:
                                                          PdfColor.fromHex(
                                                              "#c2c2c2"),
                                                    ))
                                              ]),
                                        ));
                                  },
                                ),
                              ]),
                  ])
            ]);
      },
    ),
  );
  return resume10.save();
}
