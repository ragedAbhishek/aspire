import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> resumeFour({
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
  final resume4 = Document();

  final nameFont = await PdfGoogleFonts.montserratBold();
  final jobTitleFont = await PdfGoogleFonts.montserratMedium();

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

  resume4.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 30,
        marginRight: 30,
        marginTop: 28,
        marginBottom: 28,
      ),
      build: (context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 220,
                              //color: PdfColors.red100,
                              child: Text(
                                  "${firstName.toString().toUpperCase()}\n${lastName.toString().toUpperCase()}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      font: nameFont,
                                      fontSize: 34))),
                          SizedBox(height: 8),
                          Container(
                              width: 220,
                              //color: PdfColors.red100,
                              child: Text(
                                  capitalizeFirstLetterOfEachWord(
                                    designation.toString(),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      font: jobTitleFont,
                                      color: PdfColors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal)))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              height: 1,
                              width: 200,
                              color: const PdfColor.fromInt(0xFFD4D4D4)),
                          SizedBox(height: 4),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    "${countryCodeToDailingCode(countryCode)} $phoneNo",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            const PdfColor.fromInt(0xFF777777),
                                        fontWeight: FontWeight.normal)),
                                SizedBox(width: 10),
                                Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: PdfColors.black,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Image(
                                            height: 10,
                                            width: 10,
                                            phoneCallIconWhite)))
                              ]),
                          SizedBox(height: 4),
                          Container(
                              height: 1,
                              width: 200,
                              color: const PdfColor.fromInt(0xFFD4D4D4)),
                          SizedBox(height: 4),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  //color: PdfColors.red100,
                                  alignment: Alignment.centerRight,
                                  width: 172,
                                  child: Text("$emailAddress",
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: const PdfColor.fromInt(
                                              0xFF777777),
                                          fontWeight: FontWeight.normal)),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: PdfColors.black,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Image(
                                            height: 10,
                                            width: 10,
                                            emailIconWhite)))
                              ]),
                          SizedBox(height: 4),
                          Container(
                              height: 1,
                              width: 200,
                              color: const PdfColor.fromInt(0xFFD4D4D4)),
                          SizedBox(height: 4),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  //color: PdfColors.red100,
                                  alignment: Alignment.centerRight,
                                  width: 172,
                                  child: Text(
                                      capitalizeFirstLetterOfEachWord(
                                          address.toString()),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: const PdfColor.fromInt(
                                              0xFF777777),
                                          fontWeight: FontWeight.normal)),
                                ),
                                SizedBox(width: 10),
                                Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: PdfColors.black,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Image(
                                            height: 10,
                                            width: 10,
                                            pinIconWhite)))
                              ]),
                          SizedBox(height: 4),
                          Container(
                              height: 1,
                              width: 200,
                              color: const PdfColor.fromInt(0xFFD4D4D4)),
                        ])
                  ]),
              SizedBox(height: 24),
              Container(
                  width: double.infinity,
                  height: 1,
                  color: const PdfColor.fromInt(0xFFD4D4D4)),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text("PROFILE",
                              style: TextStyle(
                                  color: PdfColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 16),
                          Container(
                              width: 162,
                              //color: PdfColors.red100,
                              child: Text(profile.toString(),
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: const PdfColor.fromInt(0xFF777777),
                                      fontWeight: FontWeight.normal))),
                          SizedBox(height: 20),
                          education!.isEmpty
                              ? SizedBox(height: 0)
                              : Container(
                                  height: 1,
                                  width: 162,
                                  color: const PdfColor.fromInt(0xFFD4D4D4)),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 16),
                          education.isEmpty
                              ? SizedBox(height: 0)
                              : Text("EDUCATION",
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 162,
                                                //color: PdfColors.red100,
                                                child: Text(
                                                    educations.degree
                                                        .toString()
                                                        .toUpperCase(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                width: 162,
                                                //color: PdfColors.red100,
                                                child: Text(
                                                    educations.schoolOrCollege
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                //color: PdfColors.red100,
                                                width: 162,
                                                child: Text(
                                                    "${educations.start} - ${educations.end}",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              )
                                            ]));
                                  },
                                ),
                          skill!.isEmpty
                              ? SizedBox(height: 0)
                              : Container(
                                  width: 172,
                                  height: 1,
                                  color: const PdfColor.fromInt(0xFFD4D4D4)),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 24),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : Text("SKILLS",
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                          skill.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 16),
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
                                            const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  // //color: PdfColors.red100,
                                                  width: 84,
                                                  child: RichText(
                                                      maxLines: 2,
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text: "- ",
                                                            style: TextStyle(
                                                                color: PdfColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                            text: skills
                                                                .skillName
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: const PdfColor
                                                                    .fromInt(
                                                                    0xFF777777),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                      ]))),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: 72,
                                                height: 2.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            99)),
                                                child: LinearProgressIndicator(
                                                    value: skills.expertise,
                                                    backgroundColor:
                                                        const PdfColor.fromInt(
                                                            0xFFD4D4D4),
                                                    valueColor:
                                                        PdfColors.black),
                                              )
                                            ]));
                                  },
                                ),
                        ]),
                    SizedBox(width: 20),
                    Container(
                        height: 649,
                        width: 1,
                        color: const PdfColor.fromInt(0xFFD4D4D4)),
                    SizedBox(width: 20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          experience!.isEmpty
                              ? SizedBox(height: 0)
                              : Text("WORK EXPERIENCE",
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                          experience.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 16),
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
                                            const EdgeInsets.only(bottom: 24),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 332,
                                                //color: PdfColors.red100,
                                                child: Text(
                                                    experiences.jobTitle
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                width: 332,
                                                //color: PdfColors.red100,
                                                child: Text(
                                                    "${experiences.employer.toString()} - ${capitalizeFirstLetterOfEachWord(experiences.city.toString())}",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                              SizedBox(height: 2),
                                              Container(
                                                width: 332,
                                                //color: PdfColors.red100,
                                                child: Text(
                                                    "${experiences.start} - ${experiences.end}",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                width: 332,
                                                //color: PdfColors.red100,
                                                child: Text(
                                                    experiences.description
                                                        .toString(),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                            ]));
                                  },
                                ),
                          experience.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 16),
                          project!.isEmpty
                              ? SizedBox(height: 0)
                              : Text("EXPERIENCE",
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                          project.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 16),
                          project.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: project.length,
                                  itemBuilder: (context, int index) {
                                    final projects = project[index];
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 24),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                //color: PdfColors.red100,
                                                width: 332,
                                                child: Text(
                                                    projects.projectName
                                                        .toString()
                                                        .toUpperCase(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              SizedBox(height: 2),
                                              Container(
                                                //color: PdfColors.red100,
                                                width: 332,
                                                child: Text(
                                                    projects.projectDate,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                width: 332,
                                                //color: PdfColors.red100,
                                                child: Text(
                                                    projects.projectDescription
                                                        .toString(),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                            ]));
                                  },
                                ),
                          project.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 16),
                          certificate!.isEmpty
                              ? SizedBox(height: 0)
                              : Text("CERTIFICATE",
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                          certificate.isEmpty
                              ? SizedBox(height: 0)
                              : SizedBox(height: 16),
                          certificate.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: certificate.length,
                                  itemBuilder: (context, int index) {
                                    final certificates = certificate[index];
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 24),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                //color: PdfColors.red100,
                                                width: 332,
                                                child: Text(
                                                    certificates.issuedFor
                                                        .toString()
                                                        .toUpperCase(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              SizedBox(height: 2),
                                              Container(
                                                //color: PdfColors.red100,
                                                width: 332,
                                                child: Text(
                                                    "${certificates.issuingBody.toString()}, ${certificates.issuedOn.toString()}",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF777777),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                            ]));
                                  },
                                ),
                        ])
                  ])
            ]);
      },
    ),
  );
  return resume4.save();
}
