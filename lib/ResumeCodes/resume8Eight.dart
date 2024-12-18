import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> resumeEight({
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
  final resume8 = Document();

  resume8.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 42,
        marginRight: 42,
        marginTop: 30,
        marginBottom: 30,
      ),
      build: (context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Center(
                child: Container(
                    width: 392,
                    // color: PdfColors.lightGreenAccent700,
                    child: Center(
                        child: Text(
                            "${firstName.toString().toUpperCase()} ${lastName.toString().toUpperCase()}",
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                // font: nameFont,
                                color: PdfColors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                fontSize: 32)))),
              ),
              SizedBox(height: 8),
              Center(
                  child: Container(
                      width: 392,
                      child: Center(
                          child: Text(designation.toString().toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: const PdfColor.fromInt(0xFF444343),
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 4,
                                  fontSize: 14))))),
              SizedBox(height: 20),
              Center(
                  child: Container(
                      width: 440,
                      // color: PdfColors.amberAccent700,
                      child: Center(
                          child: Text(
                              "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}  |  ${emailAddress.toString()}   |  ${address.toString()}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: const PdfColor.fromInt(0xFF444343),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11))))),
              SizedBox(height: 20),
              Container(
                  height: 1,
                  width: double.infinity,
                  color: PdfColor.fromHex("#c2c2c2")),
              SizedBox(height: 14),
              Text(
                "PROFILE",
                style: TextStyle(
                    color: PdfColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 2),
              ),
              SizedBox(height: 10),
              Text(profile.toString(),
                  maxLines: 4,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 11,
                      color: const PdfColor.fromInt(0xFF444343),
                      lineSpacing: 2)),
              SizedBox(height: 14),
              Container(
                  height: 1,
                  width: double.infinity,
                  color: PdfColor.fromHex("#c2c2c2")),
              experience!.isEmpty ? SizedBox(height: 0) : SizedBox(height: 14),
              experience.isEmpty
                  ? SizedBox(height: 0)
                  : Text(
                      "WORK EXPERIENCE",
                      style: TextStyle(
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 2),
                    ),
              experience.isEmpty ? SizedBox(height: 0) : SizedBox(height: 10),
              experience.isEmpty
                  ? SizedBox(height: 0)
                  : ListView.builder(
                      reverse: true,
                      itemCount:
                          experience.length, // the number of items in the list
                      itemBuilder: (context, int index) {
                        final experiences = experience[
                            index]; // get the skill at the current index
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      experiences.jobTitle
                                          .toString()
                                          .toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text(
                                      "${experiences.employer.toString()}, ${experiences.city.toString()}  |  ${experiences.start.toString()} - ${experiences.end.toString()}",
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal,
                                        color:
                                            const PdfColor.fromInt(0xFF444343),
                                      )),
                                  SizedBox(height: 6),
                                  Text(experiences.description.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal,
                                        color:
                                            const PdfColor.fromInt(0xFF444343),
                                      )),
                                ]));
                      },
                    ),
              project!.isEmpty
                  ? SizedBox(height: 0)
                  : experience.isEmpty
                      ? SizedBox(height: 14)
                      : SizedBox(height: 0),
              project.isEmpty
                  ? SizedBox(height: 0)
                  : Container(
                      height: 1,
                      width: double.infinity,
                      color: PdfColor.fromHex("#c2c2c2")),
              project.isEmpty ? SizedBox(height: 0) : SizedBox(height: 14),
              project.isEmpty
                  ? SizedBox(height: 0)
                  : Text(
                      "EXPERIENCE",
                      style: TextStyle(
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 2),
                    ),
              project.isEmpty ? SizedBox(height: 0) : SizedBox(height: 10),
              project.isEmpty
                  ? SizedBox(height: 0)
                  : ListView.builder(
                      reverse: true,
                      itemCount:
                          project.length, // the number of items in the list
                      itemBuilder: (context, int index) {
                        final projects = project[
                            index]; // get the skill at the current index
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    // color: PdfColors.lightGreenAccent700,
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  "${projects.projectName.toString().toUpperCase()}   ",
                                              style: TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  "|  ${projects.projectDate.toString()}",
                                              style: TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 11,
                                                  fontWeight:
                                                      FontWeight.normal))
                                        ])),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    // color: PdfColors.lightGreenAccent700,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        projects.projectDescription.toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                          color: const PdfColor.fromInt(
                                              0xFF444343),
                                        )),
                                  )
                                ]));
                      },
                    ),
              certificate!.isEmpty
                  ? SizedBox(height: 0)
                  : experience.isEmpty || project.isEmpty
                      ? SizedBox(height: 14)
                      : SizedBox(height: 0),
              certificate.isEmpty
                  ? SizedBox(height: 0)
                  : Container(
                      height: 1,
                      width: double.infinity,
                      color: PdfColor.fromHex("#c2c2c2")),
              certificate.isEmpty ? SizedBox(height: 0) : SizedBox(height: 14),
              certificate.isEmpty
                  ? SizedBox(height: 0)
                  : Text(
                      "CERTIFICATE",
                      style: TextStyle(
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 2),
                    ),
              certificate.isEmpty ? SizedBox(height: 0) : SizedBox(height: 10),
              certificate.isEmpty
                  ? SizedBox(height: 0)
                  : ListView.builder(
                      reverse: true,
                      itemCount:
                          certificate.length, // the number of items in the list
                      itemBuilder: (context, int index) {
                        final certificates = certificate[
                            index]; // get the skill at the current index
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      // color: PdfColors.lightGreenAccent700,
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "${certificates.issuedFor.toString().toUpperCase()}   ",
                                                style: TextStyle(
                                                    color: PdfColors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    "|  ${certificates.issuedOn.toString()}",
                                                style: TextStyle(
                                                    color: PdfColors.black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.normal))
                                          ]))),
                                  SizedBox(height: 2),
                                  Container(
                                    // color: PdfColors.lightGreenAccent700,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        certificates.issuingBody.toString(),
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                          color: const PdfColor.fromInt(
                                              0xFF444343),
                                        )),
                                  )
                                ]));
                      },
                    ),
              education!.isEmpty
                  ? SizedBox(height: 0)
                  : experience.isEmpty || project.isEmpty
                      ? SizedBox(height: 14)
                      : SizedBox(height: 0),
              education.isEmpty
                  ? SizedBox(height: 0)
                  : Container(
                      height: 1,
                      width: double.infinity,
                      color: PdfColor.fromHex("#c2c2c2")),
              education.isEmpty ? SizedBox(height: 0) : SizedBox(height: 14),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    education.isEmpty
                        ? SizedBox(height: 0)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Text(
                                  "EDUCATION",
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 2),
                                ),
                                SizedBox(height: 14),
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
                                                width: 232,
                                                // color: PdfColors
                                                //     .lightGreenAccent700,
                                                alignment: Alignment.centerLeft,
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
                                              SizedBox(height: 6),
                                              Container(
                                                width: 232,
                                                // color: PdfColors.lightGreenAccent700,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    educations.schoolOrCollege
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: const PdfColor
                                                          .fromInt(0xFF444343),
                                                    )),
                                              ),
                                              Container(
                                                width: 232,
                                                // color: PdfColors.lightGreenAccent700,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "${educations.start.toString()} - ${educations.end.toString()}",
                                                    textAlign: TextAlign.left,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: const PdfColor
                                                          .fromInt(0xFF444343),
                                                    )),
                                              )
                                            ]));
                                  },
                                ),
                              ]),
                    skill!.isEmpty ? SizedBox(width: 0) : SizedBox(width: 32),
                    skill.isEmpty
                        ? SizedBox(height: 0)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Text(
                                  "SKILLS",
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      letterSpacing: 2),
                                ),
                                SizedBox(height: 14),
                                ListView.builder(
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
                                                          fontSize: 11,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  TextSpan(
                                                      text: skills.skillName
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: const PdfColor
                                                            .fromInt(
                                                            0xFF444343),
                                                      ))
                                                ]))));
                                  },
                                ),
                              ])
                  ])
            ]);
      },
    ),
  );
  return resume8.save();
}
