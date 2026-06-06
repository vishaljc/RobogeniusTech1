import { NextResponse } from 'next/server'

// Disable SSL verification globally in Node for this API proxy (bypasses self-signed certificate blocks)
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0'

export async function POST(request: Request) {
  try {
    const body = await request.json()
    
    console.log('Forwarding contact submission to upstream Flask API...')
    console.log('Payload:', body)

    const upstreamUrl = 'https://reliwave.relitrade.in:9010/contact'
    
    const response = await fetch(upstreamUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify({
        full_name: body.full_name,
        email: body.email,
        mobile: body.mobile,
        company: body.company,
        service: body.service,
        message: body.message
      })
    })

    if (!response.ok) {
      const errorText = await response.text().catch(() => '')
      throw new Error(`Upstream API returned status ${response.status}: ${errorText}`)
    }

    const resData = await response.json().catch(() => ({}))
    console.log('Upstream response:', resData)

    return NextResponse.json(
      { 
        success: true, 
        message: 'Your message has been received successfully.' 
      },
      { status: 201 }
    )
  } catch (error: any) {
    console.error('Error forwarding contact submission:', error)
    return NextResponse.json(
      { 
        success: false, 
        error: 'Failed to submit contact request. Please try again later.' 
      },
      { status: 500 }
    )
  }
}
