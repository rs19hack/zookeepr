From: ${ h.lca_info['event_name'] } <${ h.lca_info['contact_email'] }>
To: ${ c.person.firstname } ${ c.person.lastname } <${ c.person.email_address }>
Subject: Confirmation of your ${ c.proposal.type.name.lower() } proposal for ${ h.lca_info['event_name'] }

Dear ${ c.person.firstname },

Thank you for proposing a ${ c.proposal.type.name.lower() } for ${ h.lca_info['event_name'] }.

If you have any queries about your proposed ${ c.proposal.type.name.lower() }, please email
${ h.lca_info['emails'][c.proposal.type.name.lower()] }

Title:             ${ c.proposal.title }
Target audience:   ${ c.proposal.audience.name }
URL:               ${ c.proposal.url }
Attachments:       ${ len(c.proposal.attachments) }
Summary:           ${ c.proposal.abstract }

Travel assistance: ${ c.travel_assistance }
Accom assistance:  ${ c.travel_assistance }

Note: requesting assistance, especially travel assistance, may affect
whether or not your ${ c.proposal.type.name.lower() } is accepted.

Your ${ c.proposal.type.name.lower() } may be recorded by the conference.
% if c.proposal.video_release and c.proposal.slides_release:
You consent to ${ h.lca_info["event_parent_organisation"] } releasing both the video of your ${ c.proposal.type.name.lower() } and your
slides, if you supply them to us, under the ${ h.lca_info["media_license"] }.
% else:
%   if c.proposal.video_release:
You consent to ${ h.lca_info["event_parent_organisation"] } releasing the video of your ${ c.proposal.type.name.lower() } under the
${ h.lca_info["media_license"] }.
%   else:
You DO NOT consent to ${ h.lca_info["event_parent_organisation"] } releasing the video of your ${ c.proposal.type.name.lower() }.
%   endif
%   if c.proposal.slides_release:
You consent to ${ h.lca_info["event_parent_organisation"] } releasing your slides, if you supply them to
us, under the ${ h.lca_info["media_license"] }.
%   else:
You DO NOT consent to ${ h.lca_info["event_parent_organisation"] } releasing your slides.
%   endif
% endif
% if c.proposal.video_release or c.proposal.slides_release:

Please make sure that you are allowed to do this, if there is any doubt
(for instance, consider whether you're revealing your employer's
information or using other people's copyrighted materials.)
% endif
% if not c.proposal.video_release or not c.proposal.slides_release:

Please consider allowing us to share both the video of your ${ c.proposal.type.name.lower() } and your
slides, so that the community can gain the maximum benefit from your ${ c.proposal.type.name.lower() }!
% endif

The ${ h.event_name() } team
http://${ h.host_name() }/contact
