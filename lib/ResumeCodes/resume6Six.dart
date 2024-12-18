import 'package:aspire/Utils/methods.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> resumeSix({
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
  final resume6 = Document();

  resume6.addPage(
    Page(
      pageFormat: PdfPageFormat.standard.copyWith(
        marginLeft: 30,
        marginRight: 30,
        marginTop: 30,
        marginBottom: 30,
      ),
      build: (context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("RESUME",
                              style: TextStyle(
                                  color: const PdfColor.fromInt(0xFF444343),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(height: 16),
                          Container(
                              width: 200,
                              // color: PdfColors.lightGreenAccent700,
                              child: Text(firstName.toString().toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32))),
                          Container(
                              width: 200,
                              // color: PdfColors.lightGreenAccent700,
                              child: Text(lastName.toString().toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32))),
                          SizedBox(height: 12),
                          Container(
                              width: 200,
                              // color: PdfColors.amberAccent700,
                              child: Text(designation.toString().toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: const PdfColor.fromInt(0xFF444343),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16)))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 1,
                              width: 312,
                              decoration: BoxDecoration(
                                  color: PdfColor.fromHex("#c2c2c2"))),
                          SizedBox(height: 32),
                          Container(
                              alignment: Alignment.centerRight,
                              width: 200,
                              // color: PdfColors.lightGreenAccent700,
                              child: Text(
                                  capitalizeFirstLetterOfEachWord(
                                      address.toString()),
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: const PdfColor.fromInt(0xFF444343),
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal))),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              width: 200,
                              // color: PdfColors.lightGreenAccent700,
                              child: Text(emailAddress.toString(),
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: const PdfColor.fromInt(0xFF444343),
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal))),
                          Container(
                              alignment: Alignment.centerRight,
                              width: 200,
                              // color: PdfColors.lightGreenAccent700,
                              child: Text(
                                  "${countryCodeToDailingCode(countryCode)} ${phoneNo.toString()}",
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: const PdfColor.fromInt(0xFF444343),
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal))),
                        ])
                  ]),
              SizedBox(height: 24),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 192,
                        height: 619,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 1,
                                  width: 192,
                                  decoration: BoxDecoration(
                                      color: PdfColor.fromHex("#c2c2c2"))),
                              education!.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 20),
                              education.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("EDUCATION",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          letterSpacing: 1.4)),
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
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                        educations.degree
                                                            .toString()
                                                            .toUpperCase(),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            color: PdfColor
                                                                .fromHex(
                                                                    "#283546"),
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Container(
                                                      // color: PdfColors.amber100,
                                                      width: 180,
                                                      child: Text(
                                                          educations
                                                              .schoolOrCollege
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))),
                                                  SizedBox(height: 2),
                                                  Container(
                                                      // color: PdfColors
                                                      //     .amber100,
                                                      width: 180,
                                                      child: Text(
                                                          "${educations.start.toString()} - ${educations.end.toString()}",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                              fontSize: 11,
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
                                  : Container(
                                      height: 1,
                                      width: 192,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                              skill.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 20),
                              skill.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("SKILLS",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          letterSpacing: 1.4)),
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
                                            padding: const EdgeInsets.only(
                                                bottom: 4),
                                            child: Container(
                                                width: 180,
                                                // color: PdfColors.red100,
                                                child: RichText(
                                                    maxLines: 2,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "-   ",
                                                          style: TextStyle(
                                                              color: PdfColors
                                                                  .black,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text: skills.skillName
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                          ))
                                                    ]))));
                                      },
                                    ),
                            ])),
                    SizedBox(width: 32),
                    Container(
                        height: 619,
                        width: 312,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  height: 1,
                                  width: 312,
                                  decoration: BoxDecoration(
                                      color: PdfColor.fromHex("#c2c2c2"))),
                              SizedBox(height: 20),
                              Text("ABOUT ME",
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      letterSpacing: 1.4)),
                              SizedBox(height: 20),
                              Container(
                                  width: 312,
                                  child: Text(profile.toString(),
                                      maxLines: 5,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                        color:
                                            const PdfColor.fromInt(0xFF444343),
                                      ))),
                              experience!.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 20),
                              experience.isEmpty
                                  ? SizedBox(height: 0)
                                  : Container(
                                      height: 1,
                                      width: 312,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                              SizedBox(height: 20),
                              experience.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("WORK EXPERIENCE",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          letterSpacing: 1.4)),
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
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 312,
                                                      child: Text(
                                                          "${experiences.jobTitle.toString().toUpperCase()} | ${experiences.start.toString().toUpperCase()} - ${experiences.end.toString().toUpperCase()}",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#283546"),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Container(
                                                      width: 312,
                                                      child: Text(
                                                          "${experiences.employer.toString()} | ${capitalizeFirstLetterOfEachWord(experiences.city.toString())}",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color:
                                                                  const PdfColor
                                                                      .fromInt(
                                                                      0xFF444343),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal))),
                                                  SizedBox(height: 6),
                                                  Container(
                                                      width: 312,
                                                      child: Text(
                                                          experiences
                                                              .description
                                                              .toString(),
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 11,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                          ))),
                                                ]));
                                      },
                                    ),
                              project!.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 20),
                              project.isEmpty
                                  ? SizedBox(height: 0)
                                  : Container(
                                      height: 1,
                                      width: 312,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                              SizedBox(height: 20),
                              project.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("EXPERIENCE",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          letterSpacing: 1.4)),
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
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 312,
                                                      child: Text(
                                                          "${projects.projectName.toString().toUpperCase()} | ${projects.projectDate.toString().toUpperCase()}",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#283546"),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  SizedBox(height: 6),
                                                  Container(
                                                      width: 312,
                                                      child: Text(
                                                          projects
                                                              .projectDescription
                                                              .toString(),
                                                          maxLines: 3,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 11,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                          ))),
                                                ]));
                                      },
                                    ),
                              certificate!.isEmpty
                                  ? SizedBox(height: 0)
                                  : SizedBox(height: 20),
                              certificate.isEmpty
                                  ? SizedBox(height: 0)
                                  : Container(
                                      height: 1,
                                      width: 312,
                                      decoration: BoxDecoration(
                                          color: PdfColor.fromHex("#c2c2c2"))),
                              SizedBox(height: 20),
                              certificate.isEmpty
                                  ? SizedBox(height: 0)
                                  : Text("CERTIFICATES",
                                      style: TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          letterSpacing: 1.4)),
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
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 312,
                                                      child: Text(
                                                          "${certificates.issuedFor.toString().toUpperCase()} | ${certificates.issuedOn.toString().toUpperCase()}",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#283546"),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  SizedBox(height: 6),
                                                  Container(
                                                      width: 312,
                                                      child: Text(
                                                          certificates
                                                              .issuingBody
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 11,
                                                            color:
                                                                const PdfColor
                                                                    .fromInt(
                                                                    0xFF444343),
                                                          ))),
                                                ]));
                                      },
                                    ),
                            ]))
                  ])
            ]);
      },
    ),
  );
  return resume6.save();
}
