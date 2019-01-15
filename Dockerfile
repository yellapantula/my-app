#Mule Runtime Dockerfile v. 1.3
FROM openjdk:8-jdk
# these two can be overridden in the command line
ARG mule_ver=4.1.4
ARG mule_pkg_md5sum=305030f02d76ff393f6cda386b4d1a27
RUN groupadd mulegrp01
RUN useradd -m mule01 -p mule01.p
RUN adduser mule01 mulegrp01
#RUN usermod -a -G mulegrp01 mule01
RUN grep mulegrp01 /etc/group
RUN chmod a+w /opt
USER mule01
ENV rt_pkg_filename=mule-ee-distribution-standalone-${mule_ver}.tar.gz
#ENV rt_pkg_url=https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${mule_ver}/${rt_pkg_filename}
ENV sw_basedir=/opt
ENV rt_homedir=${sw_basedir}/mule-enterprise-standalone-${mule_ver}
ENV rt_symb_homedir=${sw_basedir}/mule
#RUN wget ${rt_pkg_url}
COPY ./${rt_pkg_filename} ${sw_basedir}/
RUN echo "${mule_pkg_md5sum} ${sw_basedir}/${rt_pkg_filename}" | md5sum -c
RUN cd ${sw_basedir} && tar xvzf ${rt_pkg_filename}
#RUN rm ~/${rt_pkg_filename}
RUN rm ${sw_basedir}/${rt_pkg_filename}
RUN ln -s ${rt_homedir} ${rt_symb_homedir}
COPY ./license.lic ${rt_symb_homedir}/conf/
COPY ./testprj01.zip ${rt_symb_homedir}/apps/
#RUN cut -d: -f1 /etc/group
#RUN groups
CMD [ "/opt/mule/bin/mule" ]
